//
//  AuthVC.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {dismiss(animated: true, completion: nil)}
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
