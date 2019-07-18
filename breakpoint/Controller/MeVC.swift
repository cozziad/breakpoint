//
//  MeVC.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class MeVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutBtnPressed(_ sender: Any) {
        AuthService.instance.signOut()
        //var window: UIWindow?
        //let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //let authVC = storyboard.instantiateViewController(withIdentifier: "AuthVC")
        //window?.makeKeyAndVisible()
        //window?.rootViewController?.present(authVC,animated: true,completion: nil)
    }
    

}
