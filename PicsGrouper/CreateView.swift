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
                                    .shadow(color: Color.customPrimary, radius: 5, y: 2)
                            }
                        }
                        .padding()
                    }
                }
                
                Button(action: {
                    self.selected.removeAll()
                    self.show.toggle()
                }) {
                    HStack(spacing: 0) {
                        Text(self.selected.isEmpty ? "写真追加 " : "写真編集")
                            .font(.custom(notosansBold, size: UIScreen.screenWidth / 20))
                        Image(systemName: self.selected.isEmpty ? "plus" : "square.and.pencil")
                            .fontWeight(.bold)
                            .font(.system(size: UIScreen.screenWidth / 20))
                    }
                    .padding()
                    .background(Color.customPrimary)
                    .foregroundColor(Color.customWhite)
                    .cornerRadius(UIScreen.screenWidth / 24)
                }
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
