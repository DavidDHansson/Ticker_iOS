//
//  ActionSheetTitleDetailHeaderView.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit

class ActionSheetTitleDetailHeaderView: UIView, ActionSheetHeader {
    
    private let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textColor = UIColor.Ticker.textColor
        l.font = Font.SanFranciscoDisplay.bold.size(21)
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()

    private let detailLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textColor = UIColor.Ticker.textColor
        l.font = Font.SanFranciscoDisplay.regular.size(14)
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        detailLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        detailLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
    }
    
    func configure(withViewModel viewModel: ActionSheetHeaderViewModel) {
        titleLabel.attributedText = viewModel.title
        detailLabel.attributedText = viewModel.detail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
