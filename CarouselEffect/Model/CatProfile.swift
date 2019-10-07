//
//  CatProfile.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 17/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class CatProfile
{
    // MARK: - Public API

    //var catID = ""
    var catImageURL = ""
    var catName = ""
    var catAge = ""
    var catGender = ""
    
    init(catName: String, catImageURL: String, catAge:String, catGender: String)
    {
        self.catImageURL = catImageURL
        self.catName = catName
        self.catAge = catAge
        self.catGender = catGender
      
    }
    
    // MARK: - Private
    // dummy data
  /*static func createCatProfile() -> [CatProfile]
    {
        return [
            CatProfile(catName: "Miu", catImage: UIImage(named: "kitten")!, catAge: "3 months", catGender: "Female"),
            
            CatProfile(catName: "Jack", catImage: UIImage(named: "cat2")!, catAge: "1 year", catGender: "Male"),
            
            CatProfile(catName: "Tompok", catImage: UIImage(named: "cat3")!, catAge: "9 months", catGender: "Female"),
            
            CatProfile(catName: "Ginger", catImage: UIImage(named: "cat4")!, catAge: "3 years", catGender: "Female"),
            
        ]
    } */
}
