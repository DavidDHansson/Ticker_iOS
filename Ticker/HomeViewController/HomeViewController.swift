//
//  HomeViewController.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displaySomething(viewModel: Home.Something.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    
    private let crashButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle("Crash", for: .normal)
        b.backgroundColor = .red
        return b
    }()
    
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
        
        view.backgroundColor = .white
        view.addSubview(crashButton)
        
        // Define Layout
        defineLayout()
        
        crashButton.addTarget(self, action: #selector(crash), for: .touchUpInside)
    }
    
    func defineLayout() {
        crashButton.translatesAutoresizingMaskIntoConstraints = false
        crashButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        crashButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        crashButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        crashButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
      
    @objc func crash() {
        fatalError()
    }
    
    // MARK: Display something
    
    func displaySomething(viewModel: Home.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
}
