//
//  GroupFeed.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/18/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {

    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var group: Group?
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groupNameLbl.text = group?.title
        DataService.instance.getEmails(forGroup: group!) { (emails) in
            self.membersLbl.text = emails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessages(forGroup: self.group!, handler: { (returnedGroupMessages) in
                self.messages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.messages.count > 0{
                    self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    func initData(forGroup group: Group){
        self.group = group
    }
    
    @IBAction func backPressed(_ sender: Any) {//dismiss(animated: true, completion: nil)
        dismissDetail()
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        messageTextField.isEnabled = false
        sendBtn.isEnabled = false
        DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (complete) in
            self.messageTextField.text = ""
        }
        messageTextField.isEnabled = true
        sendBtn.isEnabled = true
    }

}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {return 1}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell
            else {return UITableViewCell()}
        let userImage = UIImage(named: "defaultProfileImage")
        let content = messages[indexPath.row].content
        DataService.instance.getUsername(uid: messages[indexPath.row].senderId) { (returnedUsername) in
            cell.configureCell(image: userImage!, email: returnedUsername, content: content)
        }
       return cell
    }
    
    
}
