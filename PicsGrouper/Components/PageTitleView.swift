//
//  PageTitleView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI

struct PageTitleView: View {
    
    var title: String = ""
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(notosansBlack, size: UIScreen.screenWidth / 16))
                .foregroundColor(Color.customBlack)
                .padding()
            Spacer()
        }
    }
}

struct PageTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PageTitleView(title: "")
    }
}
