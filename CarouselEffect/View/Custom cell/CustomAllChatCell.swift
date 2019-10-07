//
//  CustomAllChatCell.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 23/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class CustomAllChatCell: UITableViewCell {
    
    @IBOutlet var senderName: UILabel!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet var titleOfMessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
