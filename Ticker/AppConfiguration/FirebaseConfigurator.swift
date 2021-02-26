//
//  FirebaseConfigurator.swift
//  Ticker
//
//  Created by David Hansson on 26/02/2021.
//

import UIKit
import FirebaseCore
import FirebaseInstallations

class FirebaseConfigurator: NSObject, AppConfigurationProtocol {
    
    func setup(withApplication application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        FirebaseApp.configure()
    }
    
}
