//
//  SYBadgeButton.swift
//  SYBadgeButton
//
//  Created by 友志余 on 11/05/2017.
//  Copyright © 2017 squid. All rights reserved.
//

import UIKit

enum SYBadgePosition: Int {
    case topRight = 0
    case topLeft = 1
    case bottomRight = 2
    case bottomLeft = 3
    
    case topCenter = 4
    case bottomCenter = 5
    case centerRight = 6
    case centerLeft = 7
    
    case center = 8
}

@IBDesignable class SYBadgeButton: UIButton {
    
    // MARK: - @IBInspectable Properties
    
    @IBInspectable var badgeValue: String? = nil {
        didSet {
            updateUserInterface()
        }
    }
    
    @IBInspectable var badgeTextColor: UIColor =  UIColor.white {
        didSet {
            updateUserInterface()
        }
    }
    
    @IBInspectable var badgeBackgroundColor: UIColor = UIColor.red {
        didSet {
            updateUserInterface()
        }
    }
    
    @IBInspectable var badgeOffset: CGPoint = CGPoint.zero {
        didSet {
            updateBadgeLabelConstraints()
        }
    }
    
    @IBInspectable var badgeRadius: CGFloat = 8.0 {
        didSet {
            updateUserInterface()
        }
    }
    
    @IBInspectable var badgePositionIndex: Int {
        get {
            return badgePosition.rawValue
        }
        
        set {
            guard newValue != badgePositionIndex else { return }
            if let position = SYBadgePosition(rawValue: newValue) {
                self.badgePosition = position
            } else {
                self.badgePosition = .topRight
            }
        }
    }
    
    @IBInspectable var topEdgeInset: CGFloat = 2.0 {
        didSet {
            badgeLabel.topEdgeInset = topEdgeInset
        }
    }
    
    @IBInspectable var leftEdgeInset: CGFloat = 5.0 {
        didSet {
            badgeLabel.leftEdgeInset = leftEdgeInset
        }
    }
    
    @IBInspectable var bottomEdgeInset: CGFloat = 2.0 {
        didSet {
            badgeLabel.bottomEdgeInset = bottomEdgeInset
        }
    }
    
    @IBInspectable var rightEdgeInset: CGFloat = 5.0 {
        didSet {
            badgeLabel.rightEdgeInset = rightEdgeInset
        }
    }
    
    // MARK: - Properties
    
    fileprivate let badgeLabel: SYLabel = {
        let label = SYLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 1
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var horizontalConstraint: NSLayoutConstraint? = nil
    fileprivate var verticalConstraint: NSLayoutConstraint? = nil

    fileprivate var badgePosition: SYBadgePosition = .topRight {
        didSet {
            updateBadgeLabelConstraints()
        }
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureBadgeLabel()
        updateUserInterface()
        updateBadgeLabelConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBadgeLabel()
        updateUserInterface()
        updateBadgeLabelConstraints()
    }
    
    // MARK: - Methods
    
    fileprivate func configureBadgeLabel() {
        addSubview(badgeLabel)
    }
    
    fileprivate func updateUserInterface() {
        guard badgeValue != nil else { return badgeLabel.isHidden = true }
        badgeLabel.isHidden = false
        badgeLabel.text = badgeValue
        badgeLabel.edgeInsets = UIEdgeInsets(top: topEdgeInset, left: leftEdgeInset, bottom: bottomEdgeInset, right: rightEdgeInset)
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.layer.cornerRadius = badgeRadius
    }
    
    fileprivate func updateBadgeLabelConstraints() {
        
        if let horizontalConstraint = horizontalConstraint, let verticalConstraint = verticalConstraint {
            removeConstraint(horizontalConstraint)
            removeConstraint(verticalConstraint)
        }
        
        var hConstraint: NSLayoutConstraint
        var vConstraint: NSLayoutConstraint
        
        switch badgePosition {
        case .topRight:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            
        case .topLeft:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            
        case .bottomRight:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            
        case .bottomLeft:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            
        case .topCenter:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            
        case .bottomCenter:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            
        case .centerRight:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            
        case .centerLeft:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            
        case .center:
            hConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            vConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        }
        addConstraint(hConstraint)
        addConstraint(vConstraint)
        
        self.horizontalConstraint = hConstraint
        self.verticalConstraint = vConstraint
        
        
        self.horizontalConstraint?.constant = badgeOffset.x
        self.verticalConstraint?.constant = badgeOffset.y
    }
}

@IBDesignable class SYLabel: UILabel {
    
    @IBInspectable var topEdgeInset: CGFloat = 0.0
    @IBInspectable var leftEdgeInset: CGFloat = 0.0
    @IBInspectable var bottomEdgeInset: CGFloat = 0.0
    @IBInspectable var rightEdgeInset: CGFloat = 0.0
    
    var edgeInsets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: topEdgeInset, left: leftEdgeInset, bottom: bottomEdgeInset, right: rightEdgeInset)
        }
        
        set {
            topEdgeInset = newValue.top
            leftEdgeInset = newValue.left
            bottomEdgeInset = newValue.bottom
            rightEdgeInset = newValue.right
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let originSize = super.sizeThatFits(size)
        let width = originSize.width + leftEdgeInset + rightEdgeInset
        let height = originSize.height + topEdgeInset + bottomEdgeInset
        
        let newSize = CGSize(width: width, height: height)
        return newSize
    }
    
    override var intrinsicContentSize: CGSize {
        let originSize = super.intrinsicContentSize
        let width = originSize.width + leftEdgeInset + rightEdgeInset
        let height = originSize.height + topEdgeInset + bottomEdgeInset
        
        let newSize = CGSize(width: width, height: height)
        return newSize
    }
}
