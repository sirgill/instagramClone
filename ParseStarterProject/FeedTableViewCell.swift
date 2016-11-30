//
//  FeedTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Surinder Singh Gill on 11/23/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet var postedImage: UIImageView!
    
    
    @IBOutlet var usernameLabel: UILabel!
    
    
    @IBOutlet var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
