//
//  TMIconTitleButton.swift
//  tiimo
//
//  Created by Jakob Mikkelsen on 26/10/2020.
//  Copyright © 2020 Tiimo Aps. All rights reserved.
//

import UIKit

final class TMIconTitleButton: UIButton {
    
    enum State {
        case active
        case inactive
    }
    
    // Title colors
    public var activeTitleColor: UIColor = UIColor.black
    public var inActiveTitleColor: UIColor = UIColor.lightGray
    
    // Border colors
    public var activeBorderColor: UIColor = UIColor.black
    public var inActiveBorderColor: UIColor = UIColor.lightGray
    
    private var spacing: CGFloat = 5.0
    private var activeState: State = .inactive {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjustInsets()
    }
    
    init(withSpacing spacing: CGFloat) {
        super.init(frame: .zero)
        self.spacing = spacing
        adjustInsets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        adjustInsets()
    }
    
    override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(title, for: state)
        adjustInsets()
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        adjustInsets()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        switch activeState {
        case .active:
            tintColor = activeTitleColor
            setTitleColor(activeTitleColor, for: .normal)
            layer.borderColor = activeBorderColor.cgColor
            
        case .inactive:
            tintColor = inActiveTitleColor
            setTitleColor(inActiveTitleColor, for: .normal)
            layer.borderColor = inActiveBorderColor.cgColor
        }
        
    }
    
    public func set(activeState: State) {
        self.activeState = activeState
    }
    
    private func adjustInsets() {
        guard let text = currentTitle ?? currentAttributedTitle?.string, !text.isEmpty else {
            titleEdgeInsets = .zero
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            return
        }
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15)
    }
    
}
