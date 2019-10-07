//
//  TabBarViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 01/10/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import DynamicColor

class TabBarViewController: UITabBarController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarColor = DynamicColor(hex: 0x95ADBE)
        self.view.backgroundColor = tabBarColor
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
