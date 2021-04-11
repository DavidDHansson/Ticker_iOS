//
//  HomeInteractor.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func fetchContent(request: Home.Articles.Request)
}

protocol HomeDataStore {
    var articles: [Article] { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    var articles: [Article] = []
    
    func fetchContent(request: Home.Articles.Request) {
    
        // TODO: update the per amount on every api call, if call maybe is 39, so infinit scroll is possible
        
        // If first page
        if request.page == 0 {
            articles.removeAll()
        }
        
        // Exclude providers
        var excludedProviders = ["exclude": []]
        if let providers = UserDefaults.standard.array(forKey: "excludedProviders") as? [String] {
            excludedProviders = ["exclude": providers]
        }
        
        let apiRequest = APIRequest(endpoint: "home?page=\(request.page)&per=\(40)", method: .post, parameters: excludedProviders)
        APIManager.shared.callAPI(of: [Article].self, withRequest: apiRequest, completion: { [weak self] (result) in
            switch result {
            case .success(let articles):

                self?.articles += articles

                self?.presenter?.presentArticles(response: .init(articles: self?.articles, page: request.page, error: nil))
            case .failure(let error):
                self?.presenter?.presentArticles(response: .init(articles: nil, page: request.page, error: error))
            }
        })
    }

}
