//
//  SettingsViewController.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SettingsDisplayLogic: class {
    func displaySomething(viewModel: Settings.Something.ViewModel)
}

class SettingsViewController: UIViewController, SettingsDisplayLogic {
    var interactor: SettingsBusinessLogic?
    var router: (NSObjectProtocol & SettingsRoutingLogic & SettingsDataPassing)?
    
    private let tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .grouped)
        t.backgroundColor = .clear
        t.rowHeight = 50
        t.separatorStyle = .none
        t.showsVerticalScrollIndicator = false
        t.allowsSelection = false
        t.allowsMultipleSelection = false
        t.register(SettingsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "SettingsTableViewHeader")
        t.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        return t
    }()
    
    let settings: [[Settings.Setting]] = [
        [.init(title: "Åben i Safari", type: .openInSafari),
         .init(title: "Del med en ven", type: .share)],
        [.init(title: "euroinvester", type: .provider("euroinvester")),
        .init(title: "r/stocks", type: .provider("r/stocks")),
        .init(title: "DR Penge", type: .provider("dr"))]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Indstillinger"
        view.backgroundColor = UIColor.Ticker.viewBackgroundColor
        
        // Add subviews
        view.addSubview(tableView)
        
        // Define layout
        defineLayout()
        
        // Setup delegates
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
    
    func displaySomething(viewModel: Settings.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
}

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
        
        switch indexPath.row {
        case 0:
            cell.configure(withViewModel: .init(title: setting.title, position: .first, type: setting.type))
        case settings[indexPath.section].count - 1:
            cell.configure(withViewModel: .init(title: setting.title, position: .last, type: setting.type))
        default:
            cell.configure(withViewModel: .init(title: setting.title, position: .middle, type: setting.type))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0, let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingsTableViewHeader") as? SettingsTableViewHeader else { return UIView(frame: .zero) }
        return view
    }

}
