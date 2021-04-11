//
//  SettingsInteractor.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SettingsBusinessLogic {
    func fetchProviders(request: Settings.Provider.Request)
}

protocol SettingsDataStore {
    //var name: String { get set }
}

class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore {
    var presenter: SettingsPresentationLogic?
    var worker: SettingsWorker?
    //var name: String = ""
    
    
    func fetchProviders(request: Settings.Provider.Request) {
        
        let request = APIRequest(endpoint: "providers", method: .get, parameters: nil)
        
        APIManager.shared.callAPI(of: [Settings.SettingsProvider].self, withRequest: request, completion: { [weak self] (result) in
            switch result {
            case .success(let providers):
                let response = Settings.Provider.Response(error: nil, providers: providers)
                self?.presenter?.presentProviders(response: response)
            case .failure(let error):
                let response = Settings.Provider.Response(error: error, providers: nil)
                self?.presenter?.presentProviders(response: response)
            }
        })
    }
}
