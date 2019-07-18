//
//  MeVC.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    @IBAction func logoutBtnPressed(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Log out?", message: "Are you sure you want to logout", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Log out?", style: .destructive) { (buttonTapped) in
            AuthService.instance.signOut()
            let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC")
            self.present(authVC!, animated: true, completion: nil)
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    }
    

}
