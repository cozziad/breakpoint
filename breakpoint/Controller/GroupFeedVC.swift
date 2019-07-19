//
//  GroupFeed.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/18/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groupNameLbl.text = group?.title
        DataService.instance.getEmails(forGroup: group!) { (emails) in
            self.membersLbl.text = emails.joined(separator: ", ")
        }
        
    }
    
    func initData(forGroup group: Group){
        self.group = group
    }
    
    @IBAction func backPressed(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBAction func sendBtnPressed(_ sender: Any) {
    }
    
   

}
