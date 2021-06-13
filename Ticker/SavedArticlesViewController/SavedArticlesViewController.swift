//
//  SavedArticlesViewController.swift
//  Ticker
//
//  Created by David Hansson on 13/06/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SafariServices

protocol SavedArticlesDisplayLogic: AnyObject {
    func displaySomething(viewModel: SavedArticles.Something.ViewModel)
}

class SavedArticlesViewController: UIViewController, SavedArticlesDisplayLogic {
    var interactor: SavedArticlesBusinessLogic?
    var router: (NSObjectProtocol & SavedArticlesRoutingLogic & SavedArticlesDataPassing)?
    
    // MARK: Variables
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
    
    private var articles: [Article] = UserDefaults.standard.structArrayData(Article.self, forKey: "savedArticles")
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Ticker.viewBackgroundColor
        
        // Add subviews
        view.addSubview(tableView)
        
        // Define layout
        defineLayout()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    private func defineLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: Display something
    
    func displaySomething(viewModel: SavedArticles.Something.ViewModel) {
        
    }
    
}

extension SavedArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewControllerArticleCell", for: indexPath) as? HomeViewControllerArticleCell else { return UITableViewCell(frame: .zero) }
        let article = articles[indexPath.row]
        
        let viewModel = HomeViewControllerArticleCell.ViewModel(id: article.id, title: article.title ?? "", image: article.img, url: article.link, providerImage: article.providerImage, provider: article.provider, providerInfo: article.providerText, providerURL: article.providerLink, displayDate: article.displayDate)
        cell.delegate = self
        cell.configure(withViewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SavedArticlesViewController: HomeViewControllerArticleCellDelegate {
    
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
    
    func openURL(_ rawURL: String?) {
        switch UserDefaults.standard.bool(forKey: "shouldOpenInSafari") {
        case true:
            openURLInSafari(rawURL)
        case false:
            openURLInApp(rawURL)
        }
    }
    
    func share(withURL rawURL: String?, withTitle title: String?) {
        guard let url = rawURL, let shareURL = NSURL(string: url) else { return }
        let shareTitle = "Nyhed fra Ticker Appen: \(title ?? "")\n\n"
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        var act: UIActivityViewController!
        act = UIActivityViewController(activityItems: [shareTitle, shareURL], applicationActivities: nil)
        act.popoverPresentationController?.sourceView = view
        act.popoverPresentationController?.permittedArrowDirections = .any
        present(act, animated: true, completion: nil)
    }
    
    func openMenu(withId id: String) {
        guard let article = articles.first(where: { $0.id == id }) else {
            presentSimpleAlert(withTitle: "Error", withMessage: nil, completion: nil)
            return
        }
        
        var savedArticles: [Article] = UserDefaults.standard.structArrayData(Article.self, forKey: "savedArticles")
        let isArticleSaved = savedArticles.contains { $0.id == id }
        
        let actionSheet = ActionSheetController()
        let openAction = ActionSheetAction(title: NSAttributedString(string: "Åben i app"), image: UIImage(systemName: "app"), style: .default, handler: { [weak self] in
            self?.openURLInApp(article.link)
        })
        let openInSafari = ActionSheetAction(title: NSAttributedString(string: "Åben i Safari"), image: UIImage(systemName: "safari"), style: .default, handler: { [weak self] in
            self?.openURLInSafari(article.link)
        })
        let saveAction = ActionSheetAction(title: NSAttributedString(string: "Gem artikel"), image: UIImage(systemName: "bookmark"), style: .default, handler: {
            savedArticles.append(article)
            UserDefaults.standard.setStructArray(savedArticles, forKey: "savedArticles")
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        })
        let unSaveAction = ActionSheetAction(title: NSAttributedString(string: "Fjern gemt artikel"), image: UIImage(systemName: "bookmark.slash"), style: .default, handler: {
            savedArticles.removeAll(where: { $0.id == id })
            UserDefaults.standard.setStructArray(savedArticles, forKey: "savedArticles")
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        })
        let shareAction = ActionSheetAction(title: NSAttributedString(string: "Del"), image: UIImage(systemName: "square.and.arrow.up"), style: .default, handler: { [weak self] in
            self?.share(withURL: article.link, withTitle: article.title)
        })
        actionSheet.configure(withHeaderType: nil, actions: [openAction, openInSafari, isArticleSaved ? unSaveAction : saveAction, shareAction])
        
        actionSheet.present(on: self)
    }
}
