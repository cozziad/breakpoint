//
//  AddGroupVCViewController.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit
import Firebase

class AddGroupVC: UIViewController {

    @IBOutlet weak var titleField: InsetTextField!
    @IBOutlet weak var descField: InsetTextField!
    @IBOutlet weak var addPeopleLbl: UILabel!
    @IBOutlet weak var addPeopleField: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addPeopleField.delegate = self
        addPeopleField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChange(){
        if addPeopleField.text == "" {
            emailArray = []
            tableView.reloadData()
        }
        else{
            DataService.instance.getEmail(forSearchQuery: addPeopleField.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func closePressed(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBAction func donePressed(_ sender: Any) {
        print ("got here 1")
        if titleField.text == nil || titleField.text == "" || descField.text == nil || descField.text == "" {return}
        print ("got here")
        DataService.instance.getIds(forUsernames: chosenUserArray) { (userIds) in
            var idsArray = userIds
            idsArray.append((Auth.auth().currentUser?.uid)!)
            DataService.instance.createGroup(withTitle: self.titleField.text!, andDescription: self.descField.text!, andUserIds: idsArray, handler: { (complete) in
                if complete{self.dismiss(animated: true, completion: nil)}
            })
        }
    }
}

extension AddGroupVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return emailArray.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let userImage = UIImage(named: "defaultProfileImage")
        let isChecked = chosenUserArray.contains(emailArray[indexPath.row])
        cell.configureCell(profileImage: userImage!, email: emailArray[indexPath.row] , isSelected: isChecked)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !chosenUserArray.contains(cell.emailLbl.text!) && cell.checkImg.isHidden == false{
            chosenUserArray.append(cell.emailLbl.text!)
            addPeopleLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }
        else if cell.checkImg.isHidden == true{
            chosenUserArray = chosenUserArray.filter({$0 != cell.emailLbl.text!})
            if chosenUserArray.count > 0 {addPeopleLbl.text = chosenUserArray.joined(separator: ", ")}
            else {addPeopleLbl.text = "add people to group"; doneBtn.isHidden = true}
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {return 1}
}
extension AddGroupVC: UITextFieldDelegate{
    
}
