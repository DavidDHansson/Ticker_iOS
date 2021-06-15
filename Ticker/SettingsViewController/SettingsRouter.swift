//
//  SettingsRouter.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol SettingsRoutingLogic {
    func routeToShareApp()
    func routeToSavedArticles()
}

protocol SettingsDataPassing {
    var dataStore: SettingsDataStore? { get }
}

class SettingsRouter: NSObject, SettingsRoutingLogic, SettingsDataPassing {
    
    weak var viewController: SettingsViewController?
    var dataStore: SettingsDataStore?
    
    // MARK: Routing
    func routeToShareApp() {
        let firstActivityItem = "Hey, tjek appen Ticker ud! Den samler alle de vigtige finans og krypto nyheder på et sted!"
        let secondActivityItem: URL = URL(string: "https://apps.apple.com/us/app/ticker/id1563711985#?platform=iphone")!

        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)

        // iPad stuff
        activityViewController.popoverPresentationController?.sourceView = viewController?.view
        activityViewController.popoverPresentationController?.permittedArrowDirections = .any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

        viewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    func routeToSavedArticles() {
        let vc = SavedArticlesViewController()
        
        vc.title = "Gemte artikler"
        vc.hidesBottomBarWhenPushed = true
        
        viewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController?.navigationController?.navigationBar.isTranslucent = false
        viewController?.navigationController?.navigationBar.tintColor = UIColor.Ticker.mainColor
        viewController?.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.Ticker.mainColor]
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
