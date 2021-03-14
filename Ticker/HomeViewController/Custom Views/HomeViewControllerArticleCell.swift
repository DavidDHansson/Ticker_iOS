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
    
    private let articleImageView: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    private let articleView: UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    private let view: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = UIColor.Ticker.subViewBackgroundColor
        return v
    }()
    
    private let providerButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.titleLabel?.font = Font.SanFranciscoDisplay.medium.size(18)
        b.setTitleColor(UIColor.Ticker.textColor, for: .normal)
        b.titleLabel?.textAlignment = .left
        return b
    }()
    
    private let providerInfoButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.titleLabel?.font = Font.SanFranciscoDisplay.regular.size(12)
        b.setTitleColor(UIColor.Ticker.textColor, for: .normal)
        b.titleLabel?.textAlignment = .left
        return b
    }()
    
    private let providerLogoButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.imageView?.contentMode = .scaleAspectFill
        return b
    }()
    
    private let dateLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textColor = UIColor.Ticker.articleDateColor
        l.font = Font.SanFranciscoDisplay.regular.size(10)
        return l
    }()
    
    private let dotMenuButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.setImage(UIImage(named: "dotmenu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        b.imageView?.tintColor = UIColor.Ticker.mainColorReversed
        return b
    }()
    
    public var openArticle: (() -> Void)?
    public var openProvider: (() -> Void)?
    
    private var articleImageViewHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        // Add subviews
        view.addSubview(providerLogoButton)
        view.addSubview(providerButton)
        view.addSubview(providerInfoButton)
        view.addSubview(dotMenuButton)
        articleView.addSubview(articleImageView)
        articleView.addSubview(titleLabel)
        articleView.addSubview(dateLabel)
        view.addSubview(articleView)
        contentView.addSubview(view)
        
        // Define Layout
        defineLayout()
        
        // Targets
        articleView.isUserInteractionEnabled = true
        articleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInBrowser)))
        providerLogoButton.addTarget(self, action: #selector(providerTapped), for: .touchUpInside)
        providerButton.addTarget(self, action: #selector(providerTapped), for: .touchUpInside)
        providerInfoButton.addTarget(self, action: #selector(providerTapped), for: .touchUpInside)
        
        updateImageBackgroundColor() 
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        articleImageView.roundAllCorners(radius: 0, backgroundColor: UIColor.Ticker.articleBorderColor, width: 1)
        articleView.roundAllCorners(radius: 8, backgroundColor: UIColor.Ticker.articleBorderColor, width: 1)
        view.roundAllCorners(radius: 8, backgroundColor: UIColor.Ticker.articleBorderColor, width: 1)
        providerLogoButton.roundAllCorners(radius: providerLogoButton.bounds.height / 2, backgroundColor: UIColor.Ticker.mainColorReversed, width: 2)

        updateImageBackgroundColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateImageBackgroundColor()
    }
    
    private func defineLayout() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        providerLogoButton.translatesAutoresizingMaskIntoConstraints = false
        providerLogoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        providerLogoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        providerLogoButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        providerLogoButton.widthAnchor.constraint(equalToConstant: 33).isActive = true
        
        providerButton.translatesAutoresizingMaskIntoConstraints = false
        providerButton.topAnchor.constraint(equalTo: providerLogoButton.topAnchor).isActive = true
        providerButton.leadingAnchor.constraint(equalTo: providerLogoButton.trailingAnchor, constant: 10).isActive = true
        providerButton.heightAnchor.constraint(equalTo: providerLogoButton.heightAnchor, multiplier: 0.5).isActive = true
        
        providerInfoButton.translatesAutoresizingMaskIntoConstraints = false
        providerInfoButton.topAnchor.constraint(equalTo: providerButton.bottomAnchor).isActive = true
        providerInfoButton.leadingAnchor.constraint(equalTo: providerLogoButton.trailingAnchor, constant: 10).isActive = true
        providerInfoButton.heightAnchor.constraint(equalTo: providerLogoButton.heightAnchor, multiplier: 0.5).isActive = true
        
        dotMenuButton.translatesAutoresizingMaskIntoConstraints = false
        dotMenuButton.centerYAnchor.constraint(equalTo: providerLogoButton.centerYAnchor).isActive = true
        dotMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        dotMenuButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dotMenuButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        articleView.translatesAutoresizingMaskIntoConstraints = false
        articleView.topAnchor.constraint(equalTo: providerLogoButton.bottomAnchor, constant: 15).isActive = true
        articleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        articleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        articleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        articleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.topAnchor.constraint(equalTo: articleView.topAnchor).isActive = true
        articleImageView.leadingAnchor.constraint(equalTo: articleView.leadingAnchor).isActive = true
        articleImageView.trailingAnchor.constraint(equalTo: articleView.trailingAnchor).isActive = true
        articleImageViewHeightConstraint = articleImageView.heightAnchor.constraint(equalToConstant: 180)
        articleImageViewHeightConstraint.isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: articleView.trailingAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 5).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: articleView.trailingAnchor, constant: -5).isActive = true
        dateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: articleView.bottomAnchor, constant: -5).isActive = true
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        dateLabel.text = nil
        
        providerLogoButton.imageView?.image = nil
        providerButton.titleLabel?.text = nil
        providerInfoButton.titleLabel?.text = nil
        
        articleImageViewHeightConstraint.constant = 0
        articleView.backgroundColor = .clear
        articleImageView.image = nil
    }
    
    public func configure(withViewModel viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.displayDate
        providerButton.setTitle(viewModel.provider, for: .normal)
        providerInfoButton.setTitle(viewModel.providerInfo, for: .normal)
        
        if let providerURL = URL(string: viewModel.providerImage) {
            providerLogoButton.af.setImage(for: .normal, url: providerURL)
        }
        
        if let urlRaw = viewModel.image, let url = URL(string: urlRaw) {
            articleImageView.af.setImage(withURL: url) // TODO: Use with placeholder image
            articleImageViewHeightConstraint.constant = 180
            layoutIfNeeded()
            
            guard let color = articleImageView.image?.averageColor else { return }
            articleView.backgroundColor = color.withAlphaComponent(0.4)
        } else {
            articleImageViewHeightConstraint.constant = 0
            layoutIfNeeded()
        }
        
    }
    
    private func updateImageBackgroundColor() {
        guard let color = articleImageView.image?.averageColor else { return }
        articleView.backgroundColor = color.withAlphaComponent(0.35)
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
