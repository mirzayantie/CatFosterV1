//
//  TextBorder.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 29/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

@IBDesignable
class TextBorder: UITextView {

    
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
    }

