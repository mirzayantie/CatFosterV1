//
//  AdoptViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 06/10/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import DynamicColor

class AdoptViewController: UIViewController {
    
    @IBOutlet weak var congratsPop: RoundedUIView!
    @IBOutlet weak var buttonToHome: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = DynamicColor(hex: 0x95ADBE)
        congratsPop.backgroundColor = color

        
        // Do any additional setup after loading the view.
    }

    @IBAction func dismissPopOut(_ sender: UIButton) {
    }
    
}
