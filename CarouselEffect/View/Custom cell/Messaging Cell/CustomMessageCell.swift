//
//  CustomMessageCell.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 18/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
}
