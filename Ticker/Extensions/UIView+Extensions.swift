//
//  UIView+Extensions.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundAllCorners(radius: CGFloat, backgroundColor: UIColor, width: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = backgroundColor.cgColor
        layer.cornerRadius = radius
        layer.masksToBounds = false
        clipsToBounds = true
    }
}
