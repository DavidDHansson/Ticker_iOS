//
//  ActionSheetController.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit
import PanModal

class ActionSheetController: UIViewController {
    
    private let stackView: UIStackView = {
        let s = UIStackView(frame: .zero)
        s.axis = .vertical
        s.spacing = 12.0
        s.clipsToBounds = true
        return s
    }()
    
    private var actions = [ActionSheetAction]()
    
    public var didDismissView: (() -> Void)?
    private var actionUsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Ticker.subViewBackgroundColor
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
        stackView.setContentHuggingPriority(.required, for: .vertical)
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    @objc private func didTapButton(sender: UIButton) {
        guard let tappedAction = actions.first(where: { $0.title?.string == sender.currentAttributedTitle?.string }) else { return }
        actionUsed = true
        dismiss(animated: true, completion: {
            tappedAction.handler?()
        })
    }
    
    private func addSpacingToStackView(withSpacing height: CGFloat) {
        let spacingView = UIView(frame: .zero)
        stackView.addArrangedSubview(spacingView)
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.heightAnchor.constraint(equalToConstant: height).isActive = true
        spacingView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
    
    public func configure(withHeaderType type: ActionSheetHeaderType?, actions: [ActionSheetAction]?) {
        DispatchQueue.main.async {
            
            self.addSpacingToStackView(withSpacing: 10)
            
            var headerView: UIView & ActionSheetHeader
            var headerViewModel: ActionSheetHeaderViewModel!
            
            switch type {
            case .title(let title):
                headerView = ActionSheetTitleHeaderView(frame: .zero)
                headerViewModel = ActionSheetHeaderViewModel(title: title, detail: nil)
            case .titleDetail(let title, let detail):
                headerView = ActionSheetTitleDetailHeaderView(frame: .zero)
                headerViewModel = ActionSheetHeaderViewModel(title: title, detail: detail)
            default:
                guard let actions = actions else { return }
                self.add(actions: actions)
                return
            }
         
            headerView.configure(withViewModel: headerViewModel)
            
            self.stackView.addArrangedSubview(headerView)
            headerView.translatesAutoresizingMaskIntoConstraints = false
            headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
            headerView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
            headerView.setContentHuggingPriority(.required, for: .vertical)
            headerView.setContentCompressionResistancePriority(.required, for: .vertical)
            
            guard let actions = actions else { return }
            self.add(actions: actions)
        }
    }
    
    private func add(actions: [ActionSheetAction]) {
        
        self.actions = actions
        
        self.addSpacingToStackView(withSpacing: 5)
        
        let actionButtons: [TMIconTitleButton] = actions.map { (action) -> TMIconTitleButton in
            let b = TMIconTitleButton(withSpacing: 10.0)
            b.setAttributedTitle(action.title, for: .normal)
            b.inActiveTitleColor = UIColor.Ticker.textColor
            b.imageView?.tintColor = UIColor.Ticker.mainColor
            b.titleLabel?.font = Font.SanFranciscoDisplay.regular.size(17)
            b.backgroundColor = UIColor.Ticker.buttonColor
            b.layer.cornerRadius = 7.0
            b.clipsToBounds = true
            b.contentHorizontalAlignment = .left
            b.addTarget(self, action: #selector(self.didTapButton(sender:)), for: .touchUpInside)
            return b
        }
        
        actionButtons.forEach {
            self.stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
            $0.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
            $0.setContentHuggingPriority(.required, for: .vertical)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
    }
    
    public func add(contentView: UIView, withMinimumHeight: CGFloat = 30) {
        stackView.addArrangedSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: withMinimumHeight).isActive = true
        contentView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        contentView.setContentHuggingPriority(.required, for: .vertical)
        contentView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    public func present(on viewController: UIViewController) {
        DispatchQueue.main.async {
            viewController.presentCustomPanModal(self)
        }
    }
    
}

extension ActionSheetController: PanModalPresentable {
    
    var longFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
    
    var shortFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    func panModalDidDismiss() {
        guard !actionUsed else { return }
        didDismissView?()
    }
    
}
