//
//  SettingsPresenter.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SettingsPresentationLogic {
    func presentSomething(response: Settings.Something.Response)
}

class SettingsPresenter: SettingsPresentationLogic {
    weak var viewController: SettingsDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Settings.Something.Response) {
        let viewModel = Settings.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
