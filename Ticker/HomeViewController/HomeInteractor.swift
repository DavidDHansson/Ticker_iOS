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
    
        if request.page == 0 {
            articles.removeAll()
        }
        
        let apiRequest = APIRequest(endpoint: "home?page=\(request.page)&per=\(30)", method: .get, parameters: nil)
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
