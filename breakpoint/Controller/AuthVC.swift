//
//  AuthVC.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func FBSignInPressed(_ sender: Any) {
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
    }
    @IBAction func emailSignInPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!,animated: true,completion: nil)
    }
    

}
