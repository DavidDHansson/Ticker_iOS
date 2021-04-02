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
    
    // TODO: Automate this
    var settings: [[Settings.Setting]] = [
        [.init(title: "Åben i Safari", type: .openInSafari, isOn: UserDefaults.standard.bool(forKey: "shouldOpenInSafari")),
         .init(title: "Del med en ven", type: .share, isOn: nil)],
        [.init(title: "euroinvester", type: .provider("euroinvester"), isOn: true),
         .init(title: "r/stocks", type: .provider("r/stocks"), isOn: true),
         .init(title: "DR Penge", type: .provider("dr"), isOn: true)]
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
        navigationController?.isNavigationBarHidden = true
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
        case .provider( _):
            // TODO: Update with userdefaults
            return
        default:
            return
        }
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
        guard setting.type == .share else { return }
        self.router?.routeToShareApp()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
