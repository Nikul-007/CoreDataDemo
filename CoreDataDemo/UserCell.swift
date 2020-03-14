//
//  UserCell.swift
//  CoreDataDemo
//
//  Created by nikunj on 14/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet var firstNameLabel : UILabel!
    @IBOutlet var lastNameLabel : UILabel!
    @IBOutlet var avtarImageView : UIImageView!
    var dataArray : UserModel!{
        didSet{
            self.firstNameLabel.text = dataArray.firstName
            self.lastNameLabel.text = dataArray.lastName

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
