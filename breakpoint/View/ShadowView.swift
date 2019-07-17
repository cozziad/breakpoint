//
//  ShadowView.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    func setupView() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
    }

}
