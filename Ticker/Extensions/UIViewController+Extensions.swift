//
//  UIViewController+Extensions.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit

extension UIViewController {
    func presentSimpleAlert(withTitle title: String?, withMessage message: String?, completion: (() -> Void)?) {
        
        let actionSheet = ActionSheetController()
        actionSheet.configure(withHeaderType: message != nil ? .titleDetail(title: NSAttributedString(string: title ?? ""), detail: NSAttributedString(string: message ?? "")) : .title(title: NSAttributedString(string: title ?? "")), actions: nil)
        actionSheet.present(on: self)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
}
