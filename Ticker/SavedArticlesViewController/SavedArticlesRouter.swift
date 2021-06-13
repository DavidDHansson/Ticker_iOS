//
//  SavedArticlesRouter.swift
//  Ticker
//
//  Created by David Hansson on 13/06/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol SavedArticlesRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SavedArticlesDataPassing {
    var dataStore: SavedArticlesDataStore? { get }
}

class SavedArticlesRouter: NSObject, SavedArticlesRoutingLogic, SavedArticlesDataPassing {
    weak var viewController: SavedArticlesViewController?
    var dataStore: SavedArticlesDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: SavedArticlesViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: SavedArticlesDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
