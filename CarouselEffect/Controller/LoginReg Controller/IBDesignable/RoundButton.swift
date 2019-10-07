//
//  RoundButton.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 26/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 0 {
    
    didSet {
        self.layer.cornerRadius = cornerRadius
    
    }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var buttonImage: UIImage? {
        
        didSet {
            updateView()
            
        }
    }
    
    func updateView() {
        let chatButton  = UIButton(type: .custom)
        if let image = UIImage(named: "chat.png") {
            chatButton.setImage(image, for: .normal)
        }
    }
}
