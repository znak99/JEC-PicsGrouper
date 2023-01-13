//
//  DismissButton.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/14.
//

import SwiftUI

struct DismissButton: View {
    var body: some View {
        HStack {
            Spacer()
            Text("ホームに戻る")
                .foregroundColor(Color.customRed)
                .font(.custom(notosansMedium, size: UIScreen.screenWidth / 32))
                .underline(true)
        }
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
    }
}
