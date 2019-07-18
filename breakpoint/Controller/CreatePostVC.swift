//
//  createPostVC.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var messageFieldText: UITextView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileEmailLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageFieldText.delegate = self
        sendBtn.bindToKeyboard()
    }

    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageFieldText.text == nil || messageFieldText.text == "" {return}
        sendBtn.isEnabled = false
        DataService.instance.uploadPost(withMessage: messageFieldText.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (success) in
            self.sendBtn.isEnabled = true
            if success{self.dismiss(animated: true, completion: nil)}
            else{
                //error
            }
        }
    }
    @IBAction func closeBtnPressed(_ sender: Any) {dismiss(animated: true, completion: nil)}


}

extension CreatePostVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView : UITextView) {
        messageFieldText.text = ""
    }
}
