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
        let position: Position
        let type: Settings.SettingType
        
        enum Position {
            case first
            case last
            case middle
        }
    }
    
    private let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.text = "Cell"
        return l
    }()
    
    private let stateSwitch: UISwitch = {
        let s = UISwitch(frame: .zero)
        s.onTintColor = UIColor.Ticker.mainColor
        return s
    }()
    
    private let mainContentView: UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    private var dividerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return v
    }()
    
    private var position: ViewModel.Position!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dividerView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        stateSwitch.isHidden = false
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        switch position {
        case .first:
            mainContentView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        case .last:
            mainContentView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
        default:
            break
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        mainContentView.backgroundColor = UIColor.Ticker.subViewBackgroundColor
        
        // Add subviews
        contentView.addSubview(mainContentView)
        mainContentView.addSubview(titleLabel)
        mainContentView.addSubview(stateSwitch)
        mainContentView.addSubview(dividerView)

        // Define layout
        defineLayout()
    }
    
    private func defineLayout() {
        
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: stateSwitch.leadingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor).isActive = true
        
        stateSwitch.translatesAutoresizingMaskIntoConstraints = false
        stateSwitch.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        stateSwitch.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -10).isActive = true
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor).isActive = true
    }
    
    public func configure(withViewModel viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        position = viewModel.position
        stateSwitch.isHidden = viewModel.type == .share
        
        guard viewModel.position == .last else { return }
        dividerView.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
