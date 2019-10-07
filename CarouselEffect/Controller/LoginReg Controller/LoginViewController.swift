//
//  LoginViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 18/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase
import DynamicColor

class LoginViewController: UIViewController {

     //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: RoundButton!
    
    @IBOutlet weak var registerButton: RoundButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let backgroundColor = DynamicColor(hex: 0xDFF0EA)
        self.view.backgroundColor = backgroundColor
        let loginButtonColor = DynamicColor(hex: 0x4F3A65)
        let registerButtonColor = DynamicColor(hex: 0x95ADBE)
        loginButton.backgroundColor = loginButtonColor
        registerButton.borderColor = loginButtonColor
        registerButton.backgroundColor = registerButtonColor
        
        // add activity indicator
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.view.addSubview(activityIndicator)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hide nav
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //show nav
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    

    @IBAction func logInPressed(_ sender: RoundButton) {
        
        activityIndicator.startAnimating()
      
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print ("Form is not valid")
            return
        }
        //Log in the user
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                //print(error!)
                let alertController = UIAlertController(title: "Error!", message: "Error \(error!.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            } else {
                print ("Login is successful!")
                let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                
                self.present(mainTabController, animated: true,completion: nil)
                self.activityIndicator.stopAnimating()
            }
        }

        
    }

    
    
}



