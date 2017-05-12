//
//  ViewController.swift
//  SYBadgeButton
//
//  Created by 友志余 on 11/05/2017.
//  Copyright © 2017 squid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 20, y: 20, width: 100, height: 50)
        let badgeButton = SYBadgeButton(frame: rect)
        badgeButton.setTitle("button", for: .normal)
        badgeButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(badgeButton)
        
        badgeButton.badgeValue = "20"
        badgeButton.badgeBackgroundColor = UIColor.brown
        badgeButton.badgeTextColor = UIColor.white
        
        // This is topLeft Position
        badgeButton.badgePositionIndex = 1
        
        // Custom offset and edge inset
        badgeButton.badgeOffset = CGPoint(x: 3, y: 3)
        badgeButton.leftEdgeInset = 10
        badgeButton.rightEdgeInset = 10
        badgeButton.topEdgeInset = 5
        badgeButton.bottomEdgeInset = 5
    }
}

