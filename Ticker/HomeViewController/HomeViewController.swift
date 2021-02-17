//
//  HomeViewController.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    private let tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.backgroundColor = .clear
        t.rowHeight = UITableView.automaticDimension
        t.separatorStyle = .none
        t.showsVerticalScrollIndicator = false
        t.clipsToBounds = false
        t.allowsSelection = false
        t.allowsMultipleSelection = false
        t.register(HomeViewControllerArticleCell.self, forCellReuseIdentifier: "HomeViewControllerArticleCell")
        return t
    }()
    
    private var viewModel: Home.Articles.ViewModel?
    private var page: Int = 0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 25, g: 26, b: 27)
        
        // Add Subviews
        view.addSubview(tableView)
        
        // Define Layout
        defineLayout()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = Home.Articles.ViewModel(articles: [
            Article(title: "Demant-kursmål hæves", description: nil, id: "1", date: Date(), imgURL: "https://euroinvestor.bmcdn.dk/media/cache/resolve/image_540x303/image/1/19778/23666642-dem.jpg", provider: "euroinvester"),
            Article(title: "Niclas Faurby: Kan du forestille dig, at din formue er mindre om 15 år?", description: nil, id: "1", date: Date(), imgURL: "https://euroinvestor.bmcdn.dk/media/cache/resolve/image_540x303/image/1/18729/23652733-penge.png", provider: "euroinvester"),
            Article(title: "Warren Buffett satser på amerikansk medicinalaktie - det mener analytikerne om den", description: nil, id: "1", date: Date(), imgURL: "https://euroinvestor.bmcdn.dk/media/cache/resolve/image_540x303/image/1/19776/23666633-g.jpg", provider: "euroinvester"),
            Article(title: "Kendt tech-investor efter Gravitys faldt kraftigt: Det mener jeg om aktien", description: nil, id: "1", date: Date(), imgURL: "https://euroinvestor.bmcdn.dk/media/cache/resolve/image_540x303/image/1/16636/23613336-gravity.jpg", provider: "euroinvester")
        ], page: 0, errorDescription: nil)
        
    }
    
    func defineLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article = viewModel?.articles?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewControllerArticleCell", for: indexPath) as? HomeViewControllerArticleCell else { return UITableViewCell(frame: .zero) }
        let viewModel = HomeViewControllerArticleCell.ViewModel(title: article.title, imageURL: article.imgURL)
        cell.configure(withViewModel: viewModel)
        return cell
    }
    
    
}
