//
//  CustomPickerView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI
import Photos

struct CustomPickerView: View {
    
    @Binding var selected: [UIImage]
    @State var data: [Images] = []
    @Binding var show: Bool
    @State var grid: [Int] = []
    @State var disabled = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if !self.grid.isEmpty {
                    PickerViewTitle()
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(self.grid, id: \.self) { i in
                                HStack(spacing: 8) {
                                    ForEach(i..<i + 3, id: \.self) { j in
                                        HStack {
                                            if j < self.data.count {
                                                Card(data: self.data[j], selected: self.$selected)
                                            }
                                        }
                                    }
//                                    if self.data.count % 3 != 0 && i == self.grid.last! {
//                                        Spacer()
//                                    }
                                }
                                .padding(.leading, (self.data.count % 3 != 0 && i == self.grid.last!) ? 15 : 0)
                            }
                        }
                        
                        Button(action: {
                            self.show.toggle()
                        }) {
                            Text("選択")
                                .foregroundColor(Color.customWhite)
                                .padding(.vertical, 10)
                                .frame(width: UIScreen.screenWidth / 2)
                        }
                        .background(Color.customPrimary.opacity((self.selected.count != 0) ? 1 : 0.5))
                        .clipShape(Capsule())
                        .padding(.bottom, 25)
                        .disabled(!(self.selected.count != 0))
                    }
                } else {
                    if self.disabled {
                        Text("アルバムにアクセスできません。")
                    } else {
                        Indicator()
                    }
                }
                
            }
            .frame(
                width: UIScreen.screenWidth / 1.12,
                height: UIScreen.screenHeight / 1.4
            )
            .background(Color.customWhite)
            .cornerRadius(12)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
        .background(Color.customBlack.opacity(0.15).edgesIgnoringSafeArea(.all))
        .onTapGesture {
            self.show.toggle()
        }
        .onAppear {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.getAllImages()
                    self.disabled = false
                } else {
                    print("not authorized")
                    self.disabled = true
                }
            }
        }
    }
    
    func getAllImages() {
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {
            req.enumerateObjects { (asset, _, _) in
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                    let data1 = Images(image: image!, selected: false)
                    self.data.append(data1)
                }
            }
            
            if req.count == self.data.count {
                self.getGrid()
            }
        }
    }
    
    func getGrid() {
        for i in stride(from: 0, to: self.data.count, by: 3) {
            self.grid.append(i)
        }
    }
}

//struct CustomPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomPickerView()
//    }
//}

struct Images {
    var image: UIImage
    var selected: Bool
}

struct Card: View {
    @State var data: Images
    @Binding var selected: [UIImage]
    var body: some View {
        ZStack {
            Image(uiImage: self.data.image)
                .resizable()
            
            if self.data.selected {
                ZStack {
                    Color.customBlack.opacity(0.5)
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: (UIScreen.screenWidth - 80) / 3, height: 90)
        .onTapGesture {
            if !self.data.selected {
                self.data.selected = true
                self.selected.append(self.data.image)
            } else {
                for i in 0..<self.selected.count {
                    if self.selected[i] == self.data.image {
                        self.selected.remove(at: i)
                        self.data.selected = false
                        return
                    }
                }
            }
        }
        
    }
}

struct Indicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}

struct PickerViewTitle: View {
    var body: some View {
        HStack {
            Text("写真を選択")
                .foregroundColor(Color.customWhite)
                .font(.custom(notosansBold, size: UIScreen.screenWidth / 24))
            Spacer()
        }
        .padding([.leading, .vertical])
        .background(Color.customPrimary)
    }
}
