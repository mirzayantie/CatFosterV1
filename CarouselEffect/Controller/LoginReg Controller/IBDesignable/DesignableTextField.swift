//
//  DesignableTextField.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 30/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
        
    }
    
    
    @IBInspectable var leftImage: UIImage? {
        
        didSet {
            updateView()
            
        }
        
    }
    
    func updateView() {
        
        guard let image = leftImage else {fatalError()}
        leftViewMode = .always
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 20, height: 20))
        
        imageView.image = image
        imageView.tintColor = tintColor
        
        var width = leftPadding + 20
        
        //modify
        if borderStyle == .none || borderStyle == .line {
            width = width + 5
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        view.addSubview(imageView)
        leftView = view
        
        
        //image is nil
        //leftViewMode = .never
    }
    
    
}
//attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor:tintColor!])
