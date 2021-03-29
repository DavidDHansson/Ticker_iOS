//
//  SettingsTableViewHeader.swift
//  Ticker
//
//  Created by David Hansson on 17/03/2021.
//

import UIKit

class SettingsTableViewHeader: UITableViewHeaderFooterView {
    
    private let mainContentView: UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = Font.SanFranciscoDisplay.bold.size(32)
        l.text = "Ticker"
        return l
    }()
    
    private let iconView: UIImageView = {
        let v = UIImageView(frame: .zero)
        v.image = UIImage(named: "logo")
        return v
    }()
    
    private let versionLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = Font.SanFranciscoDisplay.regular.size(11)
        l.textColor = UIColor.Ticker.subTitleColor
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        l.text = "Version: \(appVersion ?? "") - Build \(build ?? "")"
        return l
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        mainContentView.layer.cornerRadius = 10
        iconView.layer.cornerRadius = 8
        iconView.layer.borderWidth = 1.5
        iconView.layer.borderColor = UIColor.black.cgColor
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        mainContentView.backgroundColor = UIColor.Ticker.subViewBackgroundColor
        
        // Add subviews
        contentView.addSubview(mainContentView)
        mainContentView.addSubview(titleLabel)
        mainContentView.addSubview(iconView)
        mainContentView.addSubview(versionLabel)

        // Define layout
        defineLayout()
    }
    
    private func defineLayout() {
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 10).isActive = true
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 10).isActive = true
        iconView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -10).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iconView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -10).isActive = true
        
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        versionLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 10).isActive = true
        versionLabel.bottomAnchor.constraint(lessThanOrEqualTo: mainContentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
