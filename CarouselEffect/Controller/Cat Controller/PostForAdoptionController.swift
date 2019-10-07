//
//  PostForAdoptionController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 25/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import os.log
import Firebase
import DynamicColor


class PostForAdoptionController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var catName: UITextField!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catBreed: UITextField!
    @IBOutlet weak var catAge: UITextField!
    @IBOutlet weak var catGender: UITextField!
    @IBOutlet weak var submitButton: RoundButton!
    @IBOutlet weak var catColour: UITextField!
    @IBOutlet weak var catDescription: TextBorder!
    @IBOutlet weak var additionalInfo: TextBorder!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var infoHeightConstraint: NSLayoutConstraint!
    
    var cat: Cat?
    var imageDownloadURL = ""
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundColor = DynamicColor(hex: 0xDFF0EA)
        self.view.backgroundColor = backgroundColor
        let buttonColor = DynamicColor(hex: 0x95ADBE)
        let buttonTint = DynamicColor(hex: 0x4F3A65)
        self.submitButton.backgroundColor = buttonColor
        self.submitButton.tintColor = buttonTint
        
        //catName.delegate = self
        self.ref = Database.database().reference()
        //Set up views if editing an existing cat
        if let cat = cat {
            //navigationItem.title = cat.catName
            catName.text = cat.catName
            catGender.text = cat.catGender
            //catImage.image = cat.catImageURL
            catBreed.text = cat.catBreed
            catDescription.text = cat.catDescription
            catColour.text = cat.catColour
            additionalInfo.text = cat.additionalInfo
        }
        
        //configNavigationBar()
        //textViewSetup()
        //Enable the submit button only if the text field has a valid input
        updateSubmitButtonState()
        
    }
    
    func textViewSetup() {
        //disable scroll
        catDescription.isScrollEnabled = false
        additionalInfo.isScrollEnabled = false
        // auto resize textview height according to content
        descriptionHeight.constant = self.catDescription.contentSize.height
        infoHeightConstraint.constant = self.additionalInfo.contentSize.height
    }
    
    //MARK: Submit detail cat info to database when submit button is pressed
    
    @IBAction func submitButtonPressed(_ sender: Any) {
   
        guard let button = sender as? RoundButton, button === submitButton else {
            os_log("The submit button was not pressed, cancelling...", log: OSLog.default, type: .debug)
            return
        }
        self.saveFIRData()
        
        
    } //end of button clicked
    func saveFIRData() {
        self.uploadImage(self.catImage.image!) { (url) in
    
            self.saveAllData(name: self.catName.text!, imageURL: url!, age: self.catAge.text!, breed: self.catBreed.text!, gender: self.catGender.text!, colour: self.catColour.text!, description: self.catDescription.text!, otherInfo: self.additionalInfo.text!){ success in
                if success != nil {
                    print("yes!")
                    
                }
            }
        }
    }
    
    func uploadImage(_ image:UIImage, completion: @escaping ((_ url: URL?) ->())){
        
        let date :NSDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        //use date as cat image file name
        let randomName = "\(dateFormatter.string(from: date as Date))"
        
        //2. create a new storage reference
        let storageRef = Storage.storage().reference().child("image").child("catimage/\(randomName).png")
        
        let imgData = catImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("success")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            } else {
                print ("error")
                completion(nil)
            }
        }
    }
    
    func saveAllData(name: String, imageURL: URL, age: String, breed: String, gender: String, colour: String, description: String, otherInfo: String, completion: @escaping ((_ url: URL?) -> ())){
        

        
        var dict = [String: Any]()
        dict.updateValue(name, forKey: "name")
        dict.updateValue(imageURL.absoluteString, forKey: "photo")
        dict.updateValue(age, forKey: "age")
        dict.updateValue(breed, forKey: "breed")
        dict.updateValue(gender, forKey: "gender")
        dict.updateValue(colour, forKey: "colour")
        dict.updateValue(description, forKey: "description")
        dict.updateValue(otherInfo, forKey: "otherInfo")
        self.ref.child("cat").childByAutoId().setValue(dict)
    }
    
    
    
    //MARK: ACTION PICKER
    
    @IBAction func selectImagefromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide keyboard. It ensures that if the user taps the image view while typing in the text field, the keyboard is dismissed properly.
        //catName.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imgPickerController = UIImagePickerController()
        
        imgPickerController.sourceType = .photoLibrary
        
        imgPickerController.delegate = self
        
        present(imgPickerController, animated: true, completion: nil)
    }
    
    //MARK: imagePickerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //catImage.image = selectedImage
        self.catImage.image = selectedImage
        dismiss(animated: true, completion: nil)
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide keyboard
        catName.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSubmitButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the button when editing
        submitButton.isEnabled = false
    }
    
    //MARK: Private Methods
    
    private func updateSubmitButtonState(){

        // if all text field are not empty, enable save button
        
        [catAge, catName, catColour, catBreed, catGender].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let name = catName.text, !name.isEmpty,
            let age = catAge.text, !age.isEmpty,
            let colour = catColour.text, !colour.isEmpty,
            let breed = catBreed.text, !breed.isEmpty
            //let description = catDescription.text, !description.isEmpty
            
            else {
                
                self.submitButton.isEnabled = false
                return
        }
        
        submitButton.isEnabled = true
    }
    
}


