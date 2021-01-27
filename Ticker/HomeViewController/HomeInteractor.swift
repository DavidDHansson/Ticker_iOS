//
//  HomeInteractor.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Home.Something.Request) {
        worker = HomeWorker()
        worker?.doSomeWork()
        
        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
