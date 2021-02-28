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
    
    private let dateLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textColor = UIColor.Ticker.articleDateColor
        l.font = Font.SanFranciscoDisplay.regular.size(10)
        return l
    }()
    
    public var openArticle: (() -> Void)?
    public var openProvider: (() -> Void)?
    
    private var articleImageViewHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        // Add subviews
        view.addSubview(providerImageView)
        view.addSubview(providerButton)
        view.addSubview(providerInfoButton)
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
        
        articleView.translatesAutoresizingMaskIntoConstraints = false
        articleView.topAnchor.constraint(equalTo: providerImageView.bottomAnchor, constant: 15).isActive = true
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: articleImageView.bounds.height, width: articleView.bounds.width, height: 1)
        bottomBorder.backgroundColor = UIColor.Ticker.articleBorderColor.cgColor
        articleImageView.layer.addSublayer(bottomBorder)
        
        articleView.roundAllCorners(radius: 8, backgroundColor: UIColor.Ticker.articleBorderColor, width: 1)
        view.roundAllCorners(radius: 8, backgroundColor: UIColor.Ticker.articleBorderColor, width: 1)
        providerImageView.roundAllCorners(radius: providerImageView.bounds.height / 2, backgroundColor: UIColor.Ticker.mainColorReversed, width: 2)
        
        guard let color = articleImageView.image?.averageColor else { return }
        articleView.backgroundColor = color.withAlphaComponent(0.4)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        articleImageView.image = nil
        providerImageView.image = nil
        providerButton.titleLabel?.text = nil
        providerInfoButton.titleLabel?.text = nil
        dateLabel.text = nil
        articleView.backgroundColor = .clear
        articleImageViewHeightConstraint.constant = 180
    }
    
    public func configure(withViewModel viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.displayDate
        
        if let providerURL = URL(string: viewModel.providerImage) {
            providerImageView.af.setImage(withURL: providerURL)
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
