//
//  UIColor+Extensions.swift
//  Opus
//
//  Created by David Hansson on 25/07/2020.
//  Copyright © 2020 David Hansson. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        self.init(hex: hex, a: 1.0)
    }
    
    convenience init(hex: Int, a: CGFloat) {
        self.init(r: (hex >> 16) & 0xff, g: (hex >> 8) & 0xff, b: hex & 0xff, a: a)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
}

extension UIColor {
    struct Ticker {
        static let viewBackgroundColor = UIColor(named: "viewBackgroundColor")
        static let textColor = UIColor(named: "textColor")!
        static let subViewBackgroundColor = UIColor(named: "subViewBackgroundColor")
        static let mainColor = UIColor(named: "mainColor")!
        static let mainColorReversed = UIColor(named: "mainColorReversed")!
        static let articleBorderColor = UIColor(named: "articleBorderColor")!
        static let articleDateColor = UIColor(named: "articleDateColor")
        static let buttonColor = UIColor(named: "buttonColor")!
        static let subTitleColor = UIColor(named: "subTitleColor")
        static let settingsCellBackgroundColor = UIColor(named: "settingsCellBackgroundColor")
    }
}
