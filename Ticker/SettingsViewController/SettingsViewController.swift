//
//  SettingsViewController.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SkeletonView

protocol SettingsDisplayLogic: AnyObject {
    func displayProviders(viewModel: Settings.Provider.ViewModel)
}

class SettingsViewController: UIViewController, SettingsDisplayLogic {
    var interactor: SettingsBusinessLogic?
    var router: (NSObjectProtocol & SettingsRoutingLogic & SettingsDataPassing)?
    
    private let tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .insetGrouped)
        t.backgroundColor = .clear
        t.rowHeight = 50
        t.separatorStyle = .singleLine
        t.showsVerticalScrollIndicator = false
        t.allowsMultipleSelection = false
        t.register(SettingsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "SettingsTableViewHeader")
        t.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        return t
    }()
    
    var settings: [[Settings.Setting]] = [
        [.init(title: "Åben i Safari", type: .openInSafari, isOn: UserDefaults.standard.bool(forKey: "shouldOpenInSafari")),
         .init(title: "Gemte artikler", type: .savedArticles, isOn: nil), .init(title: "Del med en ven", type: .share, isOn: nil)]
    ]
    
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
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter()
        let router = SettingsRouter()
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
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Ticker.viewBackgroundColor
        
        // Add subviews
        view.addSubview(tableView)
        
        // Define layout
        defineLayout()
        
        // Setup delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add header to view
        addViewHeaderBar()
        
        interactor?.fetchProviders(request: .init())
    }
    
    private func defineLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func updateAction(withIndexPath indexPath: IndexPath) {
        let setting = settings[indexPath.section][indexPath.row]
        guard let isOn = setting.isOn else { return }
        settings[indexPath.section][indexPath.row].isOn = !isOn
        
        switch setting.type {
        case .openInSafari:
            UserDefaults.standard.setValue(!isOn, forKey: "shouldOpenInSafari")
        case .provider(let provider):
            var excludedProviders = UserDefaults.standard.array(forKey: "excludedProviders") ?? []
            isOn ? excludedProviders.append(provider) : excludedProviders.removeAll(where: { ($0 as? String) ?? "" == provider })
            UserDefaults.standard.setValue(excludedProviders, forKey: "excludedProviders")
        default:
            return
        }
    }
    
    func displayProviders(viewModel: Settings.Provider.ViewModel) {
        guard let providers = viewModel.providers else {
            presentSimpleAlert(withTitle: "Error", withMessage: viewModel.error?.localizedDescription ?? "", completion: nil)
            return
        }
        
        let excludedProviders = (UserDefaults.standard.array(forKey: "excludedProviders") as? [String]) ?? [String]()
        let providerSettings: [Settings.Setting] = providers.map { Settings.Setting(title: $0.title, type: .provider($0.id), isOn: !excludedProviders.contains($0.id)) }
        settings.append(providerSettings)
        tableView.reloadData()
    }
    
}

// MARK: UITableViewDelegate

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell  else { return UITableViewCell(frame: .zero) }
        let setting = settings[indexPath.section][indexPath.row]
        cell.configure(withViewModel: .init(title: setting.title, isOn: setting.isOn))
        cell.switchDidChangeAction = { [weak self] in
            self?.updateAction(withIndexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0, let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingsTableViewHeader") as? SettingsTableViewHeader else { return UIView(frame: .zero) }
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setting = settings[indexPath.section][indexPath.row]
        
        switch setting.type {
        case .share:
            self.router?.routeToShareApp()
        case .savedArticles:
            self.router?.routeToSavedArticles()
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
