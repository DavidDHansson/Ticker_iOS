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
    
    struct SettingsProvider: Decodable {
        let title: String
        let id: String
    }
    
    struct Setting {
        let title: String
        let type: SettingType
        var isOn: Bool?
    }
    
    enum SettingType: Equatable {
        case openInSafari
        case share
        case savedArticles
        case provider(String)
    }
    
    enum Provider {
        struct Request {
        }
        struct Response {
            let error: Error?
            let providers: [SettingsProvider]?
        }
        struct ViewModel {
            let error: Error?
            let providers: [SettingsProvider]?
        }
    }
}
