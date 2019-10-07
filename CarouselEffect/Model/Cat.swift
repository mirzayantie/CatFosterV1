//
//  Cat.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 03/10/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class Cat
{
    // MARK: - Public API
    
    var catImageURL = ""
    var catName = ""
    var catDescription = ""
    var catBreed = ""
    var catAge = ""
    var catGender = ""
    var catColour = ""
    var additionalInfo = ""
    
    init(catName: String, catImageURL: String, catBreed:String, catAge:String, catGender: String, catDescription: String, catColour: String, additionalInfo: String)
    {
        
       
        self.catImageURL = catImageURL
        self.catName = catName
        self.catAge = catAge
        self.catBreed = catBreed
        self.catGender = catGender
        self.catColour = catColour
        self.catDescription = catDescription
        self.additionalInfo = additionalInfo
        
    }
    
    // MARK: - Private
    // dummy data
   /* static func createCatProfile() -> [CatProfile]
    {
        return [
            CatProfile(catID: "1", catName: "Miu", catImage: UIImage(named: "kitten")!, catBreed: "Long hair", catAge: "3 months", catGender: "Female", catDescription: "Miu is playful and fun. She lets me shower her weekly and loves being combed. She has never shown me her claws ever - a very gentle girl who enjoys belly rubs and forehead kisses.", catColour: "white", additionalInfo: "Vaccinated"),
            
            CatProfile(catID: "2", catName: "Jack", catImage: UIImage(named: "cat2")!, catBreed: "Persian", catAge: "1 year", catGender: "Male", catDescription: "Jack is a very active and curious cat. He has been vaccinated and enjoys his trip to the vet. Clumsy at times, but very adorable. Although he looks like a warrior, he's afraid of the dark and will meow loudly when left on his own. ", catColour: "black", additionalInfo: ""),
            
            CatProfile(catID: "3", catName: "Tompok", catImage: UIImage(named: "cat3")!, catBreed: "Mix", catAge: "9 months", catGender: "Female", catDescription: "Tompok is playful and fun. She lets me shower her weekly and loves being combed. She has never shown me her claws ever - a very gentle girl who enjoys belly rubs and forehead kisses.", catColour: "orange", additionalInfo: "NA"),
            
            CatProfile(catID: "4", catName: "Ginger", catImage: UIImage(named: "cat4")!, catBreed: "Long Hair", catAge: "3 years", catGender: "Female", catDescription: "Ginger were rescued when she was a little kitten. She was found wondering on the road by herself. She loves food, cuddles and frequent petting.", catColour: "orange", additionalInfo: ""),
            
        ]
    } */
}

