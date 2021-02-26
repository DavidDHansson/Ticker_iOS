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
        viewController?.displayArticles(viewModel: .init(articles: response.articles, page: response.page, errorDescription: response.error.debugDescription))
    }
    
}
