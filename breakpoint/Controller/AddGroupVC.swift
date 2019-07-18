//
//  AddGroupVCViewController.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class AddGroupVC: UIViewController {

    @IBOutlet weak var titleField: InsetTextField!
    @IBOutlet weak var descField: InsetTextField!
    @IBOutlet weak var addPeopleLbl: UILabel!
    @IBOutlet weak var addPeopleField: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closePressed(_ sender: Any) {
    }
    @IBAction func donePressed(_ sender: Any) {
    }
    

}
