//
//  HomePresenter.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentArticles(response: Home.Articles.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentArticles(response: Home.Articles.Response) {
        
        if let error = response.error {
            let viewModel = Home.Articles.ViewModel(articles: nil, page: response.page, errorDescription: error.localizedDescription)
            viewController?.displayArticles(viewModel: viewModel)
        }
        
        let viewModel = Home.Articles.ViewModel(articles: response.articles, page: response.page, errorDescription: nil)
        viewController?.displayArticles(viewModel: viewModel)
    }
    
}
