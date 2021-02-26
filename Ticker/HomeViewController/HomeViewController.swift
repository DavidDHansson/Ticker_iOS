//
//  HomeViewController.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayArticles(viewModel: Home.Articles.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    private let refreshControl = UIRefreshControl()
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
        
        // Refresh control
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        
        // Fetch first page of articles
        interactor?.fetchContent(request: .init(page: 0))
    }
    
    private func defineLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func refreshArticles() {
        page = 0
        interactor?.fetchContent(request: .init(page: 0))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        guard distanceFromBottom < height else { return }
        guard page == 0 || (page + 1) * 20 == (viewModel?.articles?.count ?? 0) else { return }
        
        page += 1
        interactor?.fetchContent(request: .init(page: page))
    }
    
    func displayArticles(viewModel: Home.Articles.ViewModel) {
        self.viewModel = viewModel
        
        if let errorString = viewModel.errorDescription {
            let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article = viewModel?.articles?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewControllerArticleCell", for: indexPath) as? HomeViewControllerArticleCell else { return UITableViewCell(frame: .zero) }
        let viewModel = HomeViewControllerArticleCell.ViewModel(title: article.title ?? "", imageURL: article.img)
        cell.configure(withViewModel: viewModel)
        return cell
    }
    
    
}
