//
//  SettingsInteractor.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SettingsBusinessLogic {
    func doSomething(request: Settings.Something.Request)
}

protocol SettingsDataStore {
    //var name: String { get set }
}

class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore {
    var presenter: SettingsPresentationLogic?
    var worker: SettingsWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Settings.Something.Request) {
        worker = SettingsWorker()
        worker?.doSomeWork()
        
        let response = Settings.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
