//
//  LoginVC.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {dismiss(animated: true, completion: nil)}
    
    @IBAction func signInPressed(_ sender: Any) {
        if emailField.text == nil || emailField.text == "" || passwordField.text == nil || passwordField.text == "" {return}
        AuthService.instance.loginUserwithEmail(email: emailField.text!, andPassword: passwordField.text!) { (success, error) in
            if success {self.dismiss(animated: true, completion: nil); return}
            //else {print(String(describing: error?.localizedDescription))}
            AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, completion: { (success, error) in
                if success {
                    AuthService.instance.loginUserwithEmail(email: self.emailField.text!, andPassword: self.passwordField.text!, completion: { (success, error) in
                        if success {self.dismiss(animated: true, completion: nil); return}
                    })
                }
            })
        }
    }
}

extension LoginVC: UITextFieldDelegate{
    
}
