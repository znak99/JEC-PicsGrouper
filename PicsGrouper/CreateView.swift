//
//  CreateView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI

struct CreateView: View {
    
    @State var selected: [UIImage] = []
    @State var show = false
    
    var body: some View {
        ZStack {
            Color.customWhite.ignoresSafeArea()
            VStack {
                PageTitleView(title: "グループ作成")
                
                if !self.selected.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(self.selected, id: \.self) { i in
                                Image(uiImage: i)
                                    .resizable()
                                    .frame(width: UIScreen.screenWidth - 40, height: 250)
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Button(action: {
                    self.selected.removeAll()
                    self.show.toggle()
                }) {
                    HStack(spacing: 0) {
                        Text("写真追加 ")
                            .font(.custom(notosansBold, size: UIScreen.screenWidth / 20))
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                            .font(.system(size: UIScreen.screenWidth / 20))
                    }
                    .padding()
                    .background(Color.customPrimary)
                    .foregroundColor(Color.customWhite)
                    .cornerRadius(UIScreen.screenWidth / 24)
                    .padding(.top, 25)
                }
                .padding(.vertical, UIScreen.screenHeight / 16)
                .shadow(color: Color.customBlack.opacity(0.8), radius: 3, x: 0, y: 1)
                Spacer()
            }
            if self.show {
                CustomPickerView(selected: self.$selected, show: self.$show)
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
