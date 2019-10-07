//
//  customView.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 30/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class CustomView : UIView {
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setRadiusAndShadow() {
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 0)
        layer.shadowColor = UIColor.darkGray.cgColor
    }
}
