//
//  APIManagerConfigurator.swift
//  Ticker
//
//  Created by David Hansson on 26/02/2021.
//

import UIKit

class APIManagerConfigurator: AppConfigurationProtocol {
    
    func setup(withApplication application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        APIManager.shared.setup(withBaseURL: "https://europe-west1-prog-eksamensprojekt.cloudfunctions.net/")
    }
    
}
