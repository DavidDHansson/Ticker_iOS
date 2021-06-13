//
//  HomeViewController.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SafariServices
import SkeletonView

protocol HomeDisplayLogic: AnyObject {
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
        
        view.backgroundColor = UIColor.Ticker.viewBackgroundColor
        
        // Add Subviews
        view.addSubview(tableView)
        
        // Define Layout
        defineLayout()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add header view
        addViewHeaderBar()
        
        // Skeleton
        SkeletonAppearance.default.multilineHeight = 10
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
        
        // Refresh control
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        
        // Fetch first page of articles
        interactor?.fetchContent(request: .init(page: 0))
        
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTop),
                                               name: NSNotification.Name(rawValue: "scrollToTop"),
                                               object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutSkeletonIfNeeded()
    }
    
    private func defineLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func refreshArticles() {
        page = 0
        interactor?.fetchContent(request: .init(page: 0))
    }
    
    @objc private func scrollToTop() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.setContentOffset(.zero, animated: true)   
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Pagination
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        guard distanceFromBottom < height else { return }
        guard page == 0 || (page + 1) * 40 == (viewModel?.articles?.count ?? 0) else { return }
        
        page += 1
        interactor?.fetchContent(request: .init(page: page))
    }
    
    func displayArticles(viewModel: Home.Articles.ViewModel) {
        self.viewModel = viewModel
        tableView.hideSkeleton()
        
        if let errorString = viewModel.errorDescription {
            presentSimpleAlert(withTitle: "Error", withMessage: errorString, completion: nil)
        } else {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, SkeletonTableViewDataSource {
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HomeViewControllerArticleCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article = viewModel?.articles?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewControllerArticleCell", for: indexPath) as? HomeViewControllerArticleCell else { return UITableViewCell(frame: .zero) }
        
        let viewModel = HomeViewControllerArticleCell.ViewModel(title: article.title ?? "", image: article.img, url: article.link, providerImage: article.providerImage, provider: article.provider, providerInfo: article.providerText, providerURL: article.providerLink, displayDate: article.displayDate)
        cell.delegate = self
        cell.configure(withViewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UIContextMenu

extension HomeViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let article = viewModel?.articles?[indexPath.row] else { return nil }
        
        let menuConfiguration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: {_ in
            let openInAppAction = UIAction(title: "Åben i App", image: UIImage(systemName: "app"), handler: { [weak self] _ in
                self?.openURL(article.link)
            })
            let openInSafariAction = UIAction(title: "Åben i Safari", image: UIImage(systemName: "safari"), handler: { [weak self] _ in
                self?.openURLInSafari(article.link)
            })
            let shareAction = UIAction(title: "Del", image: UIImage(systemName: "square.and.arrow.up"), handler: { [weak self] _ in
                self?.share(withURL: article.link, withTitle: article.title)
            })
            return UIMenu(title: "", children: [openInAppAction, openInSafariAction, shareAction])
        })
        
        return menuConfiguration
    }
}

// MARK: CellDelegate

extension HomeViewController: HomeViewControllerArticleCellDelegate {
    
    func openURLInApp(_ rawURL: String?) {
        guard let url = URL(string: rawURL ?? ""), UIApplication.shared.canOpenURL(url) else {
            presentSimpleAlert(withTitle: "Error opening link", withMessage: nil, completion: nil)
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func openURLInSafari(_ rawURL: String?) {
        guard let url = URL(string: rawURL ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    func share(withURL rawURL: String?, withTitle title: String?) {
        guard let url = rawURL, let shareURL = NSURL(string: url) else { return }
        let shareTitle = "Nyhed fra Ticker Appen: \(title ?? "")\n\n"
        var act: UIActivityViewController!
        
        act = UIActivityViewController(activityItems: [shareTitle, shareURL], applicationActivities: nil)
        act.popoverPresentationController?.sourceView = view
        act.popoverPresentationController?.permittedArrowDirections = .any
        present(act, animated: true, completion: nil)
    }
    
    func presentMenuSheet(withSheet sheet: ActionSheetController) {
        sheet.present(on: self)
    }
    
    func openURL(_ rawURL: String?) {
        switch UserDefaults.standard.bool(forKey: "shouldOpenInSafari") {
        case true:
            openURLInSafari(rawURL)
        case false:
            openURLInApp(rawURL)
        }
    }
    
}
