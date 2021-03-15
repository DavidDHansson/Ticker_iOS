//
//  ActionSheetTitleHeaderView.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit

class ActionSheetTitleHeaderView: UIView, ActionSheetHeader {
    
    private let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textColor = UIColor.Ticker.textColor
        l.font = Font.SanFranciscoDisplay.bold.size(21)
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    func configure(withViewModel viewModel: ActionSheetHeaderViewModel) {
        titleLabel.attributedText = viewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
