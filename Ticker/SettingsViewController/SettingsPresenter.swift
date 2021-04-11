//
//  SettingsPresenter.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SettingsPresentationLogic {
    func presentProviders(response: Settings.Provider.Response)
}

class SettingsPresenter: SettingsPresentationLogic {
    weak var viewController: SettingsDisplayLogic?
    
    func presentProviders(response: Settings.Provider.Response) {
        let viewModel = Settings.Provider.ViewModel(error: response.error, providers: response.providers)
        viewController?.displayProviders(viewModel: viewModel)
    }
}
