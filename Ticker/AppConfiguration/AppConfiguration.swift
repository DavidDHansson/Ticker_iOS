//
//  AppConfiguration.swift
//  Ticker
//
//  Created by David Hansson on 26/02/2021.
//

import UIKit

protocol AppConfigurationProtocol {
    func setup(withApplication application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

class AppConfiguration {
    
    private let configurations: [AppConfigurationProtocol] = [APIManagerConfigurator(), FirebaseConfigurator()]
    
    init(withApplication application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        configurations.forEach { $0.setup(withApplication: application, launchOptions: launchOptions) }
    }
    
}
