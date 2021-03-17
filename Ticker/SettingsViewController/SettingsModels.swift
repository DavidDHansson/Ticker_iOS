//
//  SettingsModels.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Settings {
    // MARK: Use cases
    
    struct Setting {
        let title: String
        let type: SettingType
    }
    
    enum SettingType: Equatable {
        case openInSafari
        case share
        case provider(String)
    }
    
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}
