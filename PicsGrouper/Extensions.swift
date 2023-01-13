//
//  Extensions.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//

import Foundation
import SwiftUI

public var notosansBlack = "NotoSansJP-Black"
public var notosansBold = "NotoSansJP-Bold"
public var notosansMedium = "NotoSansJP-Medium"
public var notosansRegular = "NotoSansJP-Regular"
public var notosansLight = "NotoSansJP-Light"

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

extension Color {
    static let customWhite = Color(red: 240/255, green: 240/255, blue: 240/255)
    static let customBlack = Color(red: 15/255, green: 15/255, blue: 15/255)
    static let customPrimary = Color(red: 135/255, green: 109/255, blue: 178/255)
    static let customRed = Color(red: 194/255, green: 47/255, blue: 47/255)
}
