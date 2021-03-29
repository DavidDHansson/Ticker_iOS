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
 
    func addViewHeaderBar() {
        let statusBarView = UIView(frame: .zero)
        statusBarView.backgroundColor = UIColor.Ticker.subViewBackgroundColor
        
        view.addSubview(statusBarView)
        
        let key = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = key?.windowScene?.statusBarManager?.statusBarFrame.height
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statusBarView.heightAnchor.constraint(equalToConstant: height ?? 0).isActive = true
    }
    
}
