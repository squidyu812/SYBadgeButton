//
//  SYBadgeButton.swift
//  SYBadgeButton
//
//  Created by 友志余 on 11/05/2017.
//  Copyright © 2017 squid. All rights reserved.
//

import UIKit

public enum SYBadgePosition: Int {
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

@IBDesignable
open class SYBadgeButton: UIButton {
    
    // MARK: - @IBInspectable Properties
    
    @IBInspectable
    open var badgeValue: String? = nil {
        didSet {
            guard let badgeText = badgeValue, !badgeText.isEmpty else {
                badgeLabel.isHidden = true
                return
            }
            badgeLabel.isHidden = false
            badgeLabel.text = badgeText
        }
    }
    
    @IBInspectable
    open var badgeTextColor: UIColor =  UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    @IBInspectable
    open var badgeBackgroundColor: UIColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    @IBInspectable
    open var badgeOffset: CGPoint = CGPoint.zero {
        didSet {
            self.horizontalConstraint?.constant = badgeOffset.x
            self.verticalConstraint?.constant = badgeOffset.y
        }
    }
    
    @IBInspectable
    open var badgeRadius: CGFloat = 9.25 {
        didSet {
            badgeLabel.layer.cornerRadius = badgeRadius
        }
    }
    
    @IBInspectable
    open var badgePositionIndex: Int {
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
    
    @IBInspectable
    open var topEdgeInset: CGFloat = 2.0 {
        didSet {
            badgeLabel.topEdgeInset = topEdgeInset
        }
    }
    
    @IBInspectable
    open var leftEdgeInset: CGFloat = 5.0 {
        didSet {
            badgeLabel.leftEdgeInset = leftEdgeInset
        }
    }
    
    @IBInspectable
    open var bottomEdgeInset: CGFloat = 2.0 {
        didSet {
            badgeLabel.bottomEdgeInset = bottomEdgeInset
        }
    }
    
    @IBInspectable
    open var rightEdgeInset: CGFloat = 5.0 {
        didSet {
            badgeLabel.rightEdgeInset = rightEdgeInset
        }
    }
    
    // MARK: - Properties
    
    open var badgeFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }
    
    // MARK: Getter Properties
    
    open var badgeHeight: CGFloat {
        return badgeLabel.frame.height
    }
    
    // MARK: - File Private Properties
    
    fileprivate lazy var badgeLabel: SYLabel = {
        let label = SYLabel()
        label.font = badgeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 1
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = badgeValue
        label.isHidden = badgeValue == nil ? true : false
        label.edgeInsets = UIEdgeInsets(top: topEdgeInset, left: leftEdgeInset, bottom: bottomEdgeInset, right: rightEdgeInset)
        label.textColor = badgeTextColor
        label.backgroundColor = badgeBackgroundColor
        label.layer.cornerRadius = badgeRadius
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
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureBadgeLabel()
        updateBadgeLabelConstraints()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureBadgeLabel()
        updateBadgeLabelConstraints()
    }
    
    // MARK: - Methods
    
    fileprivate func configureBadgeLabel() {
        addSubview(badgeLabel)
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

@IBDesignable
open class SYLabel: UILabel {
    
    @IBInspectable open var topEdgeInset: CGFloat = 0.0
    @IBInspectable open var leftEdgeInset: CGFloat = 0.0
    @IBInspectable open var bottomEdgeInset: CGFloat = 0.0
    @IBInspectable open var rightEdgeInset: CGFloat = 0.0
    
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
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let originSize = super.sizeThatFits(size)
        let width = originSize.width + leftEdgeInset + rightEdgeInset
        let height = originSize.height + topEdgeInset + bottomEdgeInset
        
        let newSize = CGSize(width: width, height: height)
        return newSize
    }
    
    override open var intrinsicContentSize: CGSize {
        let originSize = super.intrinsicContentSize
        let width = originSize.width + leftEdgeInset + rightEdgeInset
        let height = originSize.height + topEdgeInset + bottomEdgeInset
        
        let newSize = CGSize(width: width, height: height)
        return newSize
    }
}
