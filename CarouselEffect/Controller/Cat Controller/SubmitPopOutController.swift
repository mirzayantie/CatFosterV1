//
//  SubmitPopOutController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 02/10/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import DynamicColor

class SubmitPopOutController: UIViewController {

    @IBOutlet weak var popOut: UIButton!
    
    @IBOutlet weak var thankYouPop: RoundedUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = DynamicColor(hex: 0x95ADBE)
        thankYouPop.backgroundColor = color
    }
    
    @IBAction func dismissPopout(_ sender: UIButton) {
        
    }
    

}
