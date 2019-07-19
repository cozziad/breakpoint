//
//  UIViewControllerExt.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/19/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func presentDetail(_ vC: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(vC,animated: false,completion: nil)
    }
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false,completion: nil)
    }
    
}
