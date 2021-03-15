//
//  PanModal+Extensions.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit
import PanModal

extension UIViewController {
    
    func presentCustomPanModal(_ viewControllerToPresent: UIViewController & PanModalPresentable, sourceView: UIView? = nil, sourceRect: CGRect = .zero) {
        DispatchQueue.main.async { [weak self] in
            if UIDevice.current.userInterfaceIdiom == .pad {
                viewControllerToPresent.modalPresentationStyle = .formSheet
                self?.present(viewControllerToPresent, animated: true, completion: nil)
            } else {
                self?.presentPanModal(viewControllerToPresent, sourceView: sourceView, sourceRect: sourceRect)
            }
        }
    }
    
}
