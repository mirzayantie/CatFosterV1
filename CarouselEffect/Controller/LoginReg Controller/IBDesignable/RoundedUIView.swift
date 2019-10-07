//
//  RoundedUIView.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 02/10/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedUIView: UIView {

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
    
    
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        
        didSet {
            self.layer.shadowOpacity = Float(shadowOpacity)
            
        }
        
    }
    
    @IBInspectable var shadowColour: UIColor = UIColor.clear {
        
        didSet {
            self.layer.shadowColor = shadowColour.cgColor
            
        }
        
    }
  

}
