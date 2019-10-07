//
//  HomeController_Extension.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 01/10/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {
  
    
    func changeRoot() {
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        

        present(mainTabController, animated: true,completion: nil)
//                let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                appDelegate?.window?.rootViewController = vc
//                appDelegate?.window?.makeKeyAndVisible()
        
    }
    
   
}
