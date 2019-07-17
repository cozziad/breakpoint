//
//  InsetTextField.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {

    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//         return self.frame.insetBy(dx: 2, dy: 0)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return self.frame.insetBy(dx: 2, dy: 0)
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return self.frame.insetBy(dx: 2, dy: 0)
//    }
//
    func setupView(){
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.attributedPlaceholder = placeholder
    }
}
