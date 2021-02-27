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
        let image: String?
        let providerImage: String
        let provider: String
        let providerInfo: String
        let displayDate: String
    }
    
    var url: String?
    
    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textColor = UIColor.Ticker.textColor
        l.font = Font.SanFranciscoDisplay.bold.size(20)
        return l
    }()
    
    private let imgView: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    private let view: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = UIColor.Ticker.subViewBackgroundColor
        return v
    }()
    
    private let providerButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.titleLabel?.font = Font.SanFranciscoDisplay.medium.size(18)
        b.setTitle("euroinvester", for: .normal)
        b.setTitleColor(UIColor.Ticker.textColor, for: .normal)
        b.titleLabel?.textAlignment = .left
        return b
    }()
    
    private let providerInfoButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.titleLabel?.font = Font.SanFranciscoDisplay.regular.size(12)
        b.setTitle("Seneste Nyheder", for: .normal)
        b.setTitleColor(UIColor.Ticker.textColor, for: .normal)
        b.titleLabel?.textAlignment = .left
        return b
    }()
    
    private let providerImageView: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    // TODO: Date label
    
    public var openArticle: (() -> Void)?
    public var openProvider: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Colors
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        // Add subviews
        view.addSubview(providerImageView)
        view.addSubview(providerButton)
        view.addSubview(providerInfoButton)
        view.addSubview(imgView)
        view.addSubview(titleLabel)
        contentView.addSubview(view)
        
        // Define Layout
        defineLayout()
        
        // Targets
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInBrowser)))
        providerImageView.isUserInteractionEnabled = true
        providerImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(providerTapped)))
        providerButton.addTarget(self, action: #selector(providerTapped), for: .touchUpInside)
        providerInfoButton.addTarget(self, action: #selector(providerTapped), for: .touchUpInside)
    }
    
    private func defineLayout() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        providerImageView.translatesAutoresizingMaskIntoConstraints = false
        providerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        providerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        providerImageView.heightAnchor.constraint(equalToConstant: 33).isActive = true
        providerImageView.widthAnchor.constraint(equalToConstant: 33).isActive = true
        
        providerButton.translatesAutoresizingMaskIntoConstraints = false
        providerButton.topAnchor.constraint(equalTo: providerImageView.topAnchor).isActive = true
        providerButton.leadingAnchor.constraint(equalTo: providerImageView.trailingAnchor, constant: 10).isActive = true
        providerButton.heightAnchor.constraint(equalTo: providerImageView.heightAnchor, multiplier: 0.5).isActive = true
        
        providerInfoButton.translatesAutoresizingMaskIntoConstraints = false
        providerInfoButton.topAnchor.constraint(equalTo: providerButton.bottomAnchor).isActive = true
        providerInfoButton.leadingAnchor.constraint(equalTo: providerImageView.trailingAnchor, constant: 10).isActive = true
        providerInfoButton.heightAnchor.constraint(equalTo: providerImageView.heightAnchor, multiplier: 0.5).isActive = true
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: providerImageView.bottomAnchor, constant: 15).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        providerImageView.layer.borderWidth = 2
        providerImageView.layer.borderColor = UIColor.Ticker.textColor?.cgColor
        providerImageView.layer.cornerRadius = providerImageView.bounds.height / 2
        providerImageView.layer.masksToBounds = false
        providerImageView.clipsToBounds = true
        
        imgView.roundCorners(corners: .allCorners, radius: 8)
        view.roundCorners(corners: .allCorners, radius: 8)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        imgView.image = nil
        providerImageView.image = nil
        providerButton.titleLabel?.text = nil
        providerInfoButton.titleLabel?.text = nil
    }
    
    public func configure(withViewModel viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        
        if let providerURL = URL(string: viewModel.providerImage) {
            providerImageView.af.setImage(withURL: providerURL)
        }
        
        if let urlRaw = viewModel.image, let url = URL(string: urlRaw) {
            imgView.af.setImage(withURL: url) // TODO: Use with placeholder image
        } else {
            // TODO: Design for no image
        }
        
    }
    
    @objc func providerTapped() {
        openProvider?()
    }
    
    @objc func openInBrowser() {
        openArticle?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
