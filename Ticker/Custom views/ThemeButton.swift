//
//  ThemeButton.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit

class ThemeButton: UIButton {
    
    public var themeBackgroundColor: UIColor? {
        get { return backgroundColor }
        set (newValue) { backgroundColor = newValue }
    }
    
}

