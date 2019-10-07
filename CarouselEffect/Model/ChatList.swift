//
//  ChatList.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 23/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class ChatList {
    
    // Properties
    var senderName = ""
    var titleOfMessage = ""
    var messageBody = ""
    var date = ""
    var userProfileImage : UIImage!
    
    //Initialization
    init(senderName: String, titleOfMessage: String, messageBody: String, date: String, userProfileImage: UIImage!) {
        self.senderName = senderName
        self.titleOfMessage = titleOfMessage
        self.messageBody = messageBody
        self.date = date
        self.userProfileImage = userProfileImage
    }
}
