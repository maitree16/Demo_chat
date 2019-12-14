//
//  ChatImageTableViewCell.swift
//  Meal_Do
//
//  Created by Dipak Kasodariya on 12/08/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import UIKit
import Foundation


class ChatImageTableViewCell: UITableViewCell {
    @IBOutlet weak var senderProfile: UIImageView!
    @IBOutlet weak var senderSendImage: UIImageView!
    
    @IBOutlet weak var ReceiverProfile: UIImageView!
    @IBOutlet weak var receiverSendImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
