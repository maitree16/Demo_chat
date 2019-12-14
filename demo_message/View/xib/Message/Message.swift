//
//  Message.swift
//  Meal_Do
//
//  Created by Dipak Kasodariya on 01/07/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import Foundation
import UIKit

class Message: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lblMsgType: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblday: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblname.font = UIFont.boldSystemFont(ofSize: 17)
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
