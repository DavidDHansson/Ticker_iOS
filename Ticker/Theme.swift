//
//  Theme.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit

class ThemeManager {
    
    static let shared = ThemeManager()
    
    public var theme: Theme {
        get {
            let index = UserDefaults.standard.integer(forKey: "selectedTheme")
            return Theme(rawValue: index) ?? .red
        } set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "selectedTheme")
            applyTheme()
        }
    }
    
    public func applyTheme() {
        
        // Set custom colors for the desired places
        UITabBar.appearance().tintColor = theme.mainColor
        
        // Update UI
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.subviews.forEach { view in
            view.removeFromSuperview()
            window.addSubview(view)
        }
        
    }
    
}

enum Theme: Int {
    case red, green, blue
    
    var mainColor: UIColor {
        switch self {
        case .red:
            return UIColor(r: 200, g: 0, b: 0)
        case .green:
            return UIColor(r: 0, g: 200, b: 0)
        case .blue:
            return UIColor(r: 0, g: 0, b: 200)
        }
    }
    
}
