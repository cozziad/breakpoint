//
//  FeedCell.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/17/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

  
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(image: UIImage, email:String, content:String){
        self.profileImg.image = image
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
    
}
