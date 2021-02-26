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
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""
    
    func fetchContent(request: Home.Articles.Request) {
        
        let apiRequest = APIRequest(endpoint: "home", method: .get, parameters: nil)
        APIManager.shared.callAPI(of: [Article].self, withRequest: apiRequest, completion: { [weak self] (result) in
            switch result {
            case .success(let articles):
                self?.presenter?.presentArticles(response: .init(articles: articles, page: request.page, error: nil))
            case .failure(let error):
                self?.presenter?.presentArticles(response: .init(articles: nil, page: request.page, error: error))
            }
        })
    }

}
