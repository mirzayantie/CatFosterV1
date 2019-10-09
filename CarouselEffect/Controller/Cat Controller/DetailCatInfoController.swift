//
//  DetailCatInfoController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 24/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//


import UIKit
import DynamicColor

class DetailCatInfoController : UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var otherInfo: UILabel!
    @IBOutlet weak var colour: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var adoptMeButton: RoundButton!
    @IBOutlet weak var ageView: RoundedUIView!
    @IBOutlet weak var genderView: RoundedUIView!
    @IBOutlet weak var breedView: RoundedUIView!
    @IBOutlet weak var colorView: RoundedUIView!
    
    var getCatImage = UIImage()
    var getCatName = ""
    var getCatBreed = ""
    var getCatAge = ""
    var getCatColour = ""
    var getCatGender = ""
    var getCatDescription = ""
    var getCatAddInfo = ""
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoViewColor = DynamicColor(hex: 0x95ADBE)
        let buttonColor = DynamicColor(hex:0x4F3A65)
        
        breedView.backgroundColor = infoViewColor
        ageView.backgroundColor = infoViewColor
        genderView.backgroundColor = infoViewColor
        colorView.backgroundColor = infoViewColor
        adoptMeButton.backgroundColor = buttonColor
        // add activity indicator
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.view.addSubview(activityIndicator)
        
        loadDetailCat()
        
    }
    
    func loadDetailCat() {
        activityIndicator.startAnimating()
        image.image = getCatImage
        name.text = "My name is \(getCatName)!"
        gender.text = getCatGender
        about.text = getCatDescription
        age.text = getCatAge
        breed.text = getCatBreed
        colour.text = getCatColour
        otherInfo.text = getCatAddInfo
        activityIndicator.stopAnimating()
    }

}
