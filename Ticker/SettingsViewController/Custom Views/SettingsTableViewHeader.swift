//
//  SettingsTableViewHeader.swift
//  Ticker
//
//  Created by David Hansson on 17/03/2021.
//

import UIKit

class SettingsTableViewHeader: UITableViewHeaderFooterView {
    
    private let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        return l
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        // Add subviews
        contentView.addSubview(titleLabel)
        
        // Define layout
        defineLayout()
    }
    
    private func defineLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
