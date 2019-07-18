//
//  AuthService.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static let instance = AuthService()
    
    func registerUser (withEmail email: String, andPassword password: String, completion: @escaping(_ status: Bool,_ error : Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else {completion(false,error); return}
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            completion(true,nil)
        }
    }
    
    func loginUserwithEmail (email: String, andPassword password: String, completion: @escaping(_ status: Bool,_ error : Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {completion(false,error); return}
            completion(true,nil)
        }
    }
    
    func signOut() {
        do {try Auth.auth().signOut()} catch{return}
    }
    
}
