//
//  SavedArticlesViewController.swift
//  Ticker
//
//  Created by David Hansson on 13/06/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SavedArticlesDisplayLogic: AnyObject {
    func displaySomething(viewModel: SavedArticles.Something.ViewModel)
}

class SavedArticlesViewController: UIViewController, SavedArticlesDisplayLogic {
    var interactor: SavedArticlesBusinessLogic?
    var router: (NSObjectProtocol & SavedArticlesRoutingLogic & SavedArticlesDataPassing)?
    
    // MARK: Variables
    
    
    
    // MARK: Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SavedArticlesInteractor()
        let presenter = SavedArticlesPresenter()
        let router = SavedArticlesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = SavedArticles.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    
    // MARK: Display something
    
    func displaySomething(viewModel: SavedArticles.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
}
