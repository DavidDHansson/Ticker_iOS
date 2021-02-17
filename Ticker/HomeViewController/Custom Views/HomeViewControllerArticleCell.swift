//
//  HomeViewControllerArticleCell.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit
import AlamofireImage

class HomeViewControllerArticleCell: UITableViewCell {
    
    struct ViewModel {
        let title: String
        let imageURL: String?
    }
    
    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.textColor = .white
        return l
    }()
    
    private let imgView: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.contentMode = .scaleAspectFill
        i.backgroundColor = .blue
        i.clipsToBounds = false
        return i
    }()
    
    private let view: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .black
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        view.addSubview(titleLabel)
        view.addSubview(imgView)
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imgView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let topBorder = CALayer()
        topBorder.borderColor = UIColor(r: 42, g: 43, b: 44).cgColor
        topBorder.borderWidth = 1
        topBorder.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 1)
        contentView.layer.addSublayer(topBorder)
        
        let bottomBorder = CALayer()
        bottomBorder.borderColor = UIColor(r: 42, g: 43, b: 44).cgColor
        bottomBorder.borderWidth = 1
        bottomBorder.frame = CGRect(x: 0, y: contentView.frame.height - 15, width: contentView.frame.width, height: 1)
        contentView.layer.addSublayer(bottomBorder)
        
        imgView.roundCorners(corners: .allCorners, radius: 8)
    }
    
    public func configure(withViewModel viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        guard let rawURL = viewModel.imageURL, let url = URL(string: rawURL) else { return }
        imgView.af.setImage(withURL: url) // TODO: Use with placeholder image
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        imgView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
