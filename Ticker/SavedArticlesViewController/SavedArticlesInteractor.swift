//
//  SavedArticlesInteractor.swift
//  Ticker
//
//  Created by David Hansson on 13/06/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SavedArticlesBusinessLogic {
    func doSomething(request: SavedArticles.Something.Request)
}

protocol SavedArticlesDataStore {
    //var name: String { get set }
}

class SavedArticlesInteractor: SavedArticlesBusinessLogic, SavedArticlesDataStore {
    var presenter: SavedArticlesPresentationLogic?
    var worker: SavedArticlesWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: SavedArticles.Something.Request) {
        worker = SavedArticlesWorker()
        worker?.doSomeWork()
        
        let response = SavedArticles.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
