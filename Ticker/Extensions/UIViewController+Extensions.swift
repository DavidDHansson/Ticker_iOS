//
//  UIViewController+Extensions.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit

extension UIViewController {
    func presentSimpleAlert(withTitle title: String?, withMessage message: String?, completion: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: completion)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
}
