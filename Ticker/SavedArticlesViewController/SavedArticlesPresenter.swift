//
//  SavedArticlesPresenter.swift
//  Ticker
//
//  Created by David Hansson on 13/06/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SavedArticlesPresentationLogic {
    func presentSomething(response: SavedArticles.Something.Response)
}

class SavedArticlesPresenter: SavedArticlesPresentationLogic {
    weak var viewController: SavedArticlesDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: SavedArticles.Something.Response) {
        let viewModel = SavedArticles.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
