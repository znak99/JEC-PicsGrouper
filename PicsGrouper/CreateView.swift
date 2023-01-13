//
//  CreateView.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import SwiftUI

struct CreateView: View {
    var body: some View {
        ZStack {
            Color.customWhite.ignoresSafeArea()
            VStack {
                PageTitleView(title: "グループ作成")
                Spacer()
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
