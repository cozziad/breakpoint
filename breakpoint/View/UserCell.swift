//
//  UserCellTableViewCell.swift
//  breakpoint
//
//  Created by Anthony Cozzi on 7/18/19.
//  Copyright © 2019 Anthony Cozzi. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    var showing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(profileImage image:UIImage, email:String, isSelected: Bool){
        self.profileImg.image = image
        self.emailLbl.text = email
        if isSelected{self.checkImg.isHidden = false}
        else{self.checkImg.isHidden = true}
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected && !showing {checkImg.isHidden = false; showing = true}
        else if selected && showing {checkImg.isHidden = true; showing = false}
    }

}
