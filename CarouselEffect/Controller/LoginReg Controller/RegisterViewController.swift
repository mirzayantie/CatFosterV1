//
//  RegisterViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 18/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase
import DynamicColor

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var emailTextfield: DesignableTextField!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var nameTextfield: DesignableTextField!
    
    @IBOutlet var passwordTextfield: DesignableTextField!
    
    @IBOutlet weak var continueButton: RoundButton!
    
    @IBOutlet weak var haveAccount: UILabel!
    
    @IBOutlet weak var loginHereButton: UIButton!
    
    var activityIndicator = UIActivityIndicatorView()
    
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add custom color
        let backgroundColor = DynamicColor(hex: 0xDFF0EA)
        self.view.backgroundColor = backgroundColor
        let continueButtonColor = DynamicColor(hex: 0x95ADBE)
        let borderColor = DynamicColor(hex: 0x4F3A65)
        continueButton.borderColor = borderColor
        continueButton.backgroundColor = continueButtonColor
        
        // add activity indicator
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.view.addSubview(activityIndicator)
        
        //reference to database
        self.ref = Database.database().reference()
        
    }
    
    // MARK Authenticate user and save profile image to storage
    @IBAction func continueButtonClicked(_ sender: RoundButton) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print ("Form is not valid")
            return
        }
        //register the user
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            self.activityIndicator.startAnimating()
            if error != nil {
                print(error!)
                
                let alertController = UIAlertController(title: "Error!", message: "Error \(error!.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
            print("creating user...")
            self.saveFIRData()
            self.activityIndicator.stopAnimating()
            
        } //create user end
        
    } //continue buttonclicked func end
    
    // MARK : Save User Data and profile image to database
    
func saveFIRData() {
    print("saving data...")
    
    guard let uid = Auth.auth().currentUser?.uid else {return}
    
            //self.uploadImage(self.userProfileImage.image!) { (url) in
                  self.saveUserData(name: self.nameTextfield.text!, uid:uid, email: self.emailTextfield.text!,
                                  password: self.passwordTextfield.text!){ success in
                    if success != nil {
                        
                }
            //}
       }
    }
    //MARK : Save user profile photo to Storage
    func uploadImage(_ image:UIImage, completion: @escaping ((_ url: URL?) ->())){

        //2. create a new storage reference
                
                // authenticate the user
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("image").child("profile_images").child("\(imageName).png")
        
        let imgData = userProfileImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("upload imagesuccess")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            } else {
                print ("upload image error")
                completion(nil)
            }
        }
    }
    
    
    func saveUserData(name: String, uid: String, email: String, password: String, completion: @escaping ((_ url: URL?) -> ())){
        
        activityIndicator.startAnimating()
        var dict = [String: Any]()
        dict.updateValue(name, forKey: "name")
        //dict.updateValue(imageURL.absoluteString, forKey: "profile_photo")
        dict.updateValue(email, forKey: "email")
        
        self.ref.child("user").child(uid).setValue(dict)
        
        print("user data saved in database!")
        print(self.emailTextfield.text!)
        print(self.passwordTextfield.text!)
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error == nil && user != nil {
                print("User login!")
                
                self?.performSegue(withIdentifier: "goToHome", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error!", message: "Error \(error!.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self?.activityIndicator.stopAnimating()
                self?.present(alertController, animated: true, completion: nil)
            }
        }

    }
    
    @IBAction func loginHereButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    /*private func registerUserIntoDatabase(uid: String, values: [String:AnyObject]) {
        
        let userReference = ref.child("users").child(uid)
        
        
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            print("Saved user successfully into Firebase database")
            self.dismiss(animated: true, completion: nil)
        })
        
        print ("Register is successful!")
        self.performSegue(withIdentifier: "regGoToCatProfile", sender: self)
        
    } */
   
}

