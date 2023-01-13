//
//  PageTitleView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI

struct PageTitle: View {
    
    var title: String = ""
    var color: Color = .customBlack
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(notosansBlack, size: UIScreen.screenWidth / 14))
                .foregroundColor(color)
                .padding([.horizontal, .top])
            Spacer()
        }
    }
}

struct PageTitle_Previews: PreviewProvider {
    static var previews: some View {
        PageTitle(title: "")
    }
}
