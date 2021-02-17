//
//  UIView+Extensions.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit

public extension UIWindow {

    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
