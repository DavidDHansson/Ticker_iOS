//
//  SettingsTableViewCell.swift
//  Ticker
//
//  Created by David Hansson on 17/03/2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    struct ViewModel {
        let title: String
        let isOn: Bool?
    }
    
    private let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = Font.SanFranciscoDisplay.regular.size(18)
        return l
    }()
    
    private let stateSwitch: UISwitch = {
        let s = UISwitch(frame: .zero)
        s.onTintColor = UIColor.Ticker.mainColor
        s.thumbTintColor = UIColor.Ticker.mainColorReversed
        return s
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        stateSwitch.isHidden = false
    }
    
    public var switchDidChangeAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(stateSwitch)

        // Define layout
        defineLayout()
        
        // Switch Target
        stateSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    private func defineLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: stateSwitch.leadingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        stateSwitch.translatesAutoresizingMaskIntoConstraints = false
        stateSwitch.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        stateSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    public func configure(withViewModel viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        guard let isOn = viewModel.isOn else {
            stateSwitch.isHidden = true
            return
        }
        stateSwitch.isOn = isOn
    }
    
    @objc func switchChanged() {
        switchDidChangeAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
