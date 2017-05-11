//
//  SYBadgeButton.swift
//  SYBadgeButton
//
//  Created by 友志余 on 11/05/2017.
//  Copyright © 2017 squid. All rights reserved.
//

import UIKit

@IBDesignable class SYBadgeButton: UIButton {
    
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
    
    fileprivate func configureBadgeLabel() {
        addSubview(badgeLabel)
        let horizontalConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(horizontalConstraint)
        addConstraint(verticalConstraint)

        self.horizontalConstraint = horizontalConstraint
        self.verticalConstraint = verticalConstraint
//        let views: [String: Any] = ["badgeLabel": badgeLabel]
//        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[badgeLabel]-0-|", options: [], metrics: nil, views: views)
//        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[badgeLabel]", options: [], metrics: nil, views: views)
//        addConstraints(horizontalConstraints)
//        addConstraints(verticalConstraints)
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
        horizontalConstraint?.constant = badgeOffset.x
        verticalConstraint?.constant = badgeOffset.y
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
