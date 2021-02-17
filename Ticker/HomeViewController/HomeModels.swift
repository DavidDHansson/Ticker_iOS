//
//  HomeModels.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Home {
    enum Articles {
        struct Request {
            let page: Int?
        }
        struct Response {
            let articles: [Article]?
            let page: Int
            let error: Error?
        }
        struct ViewModel {
            let articles: [Article]?
            let page: Int
            let errorDescription: String?
        }
    }
}
