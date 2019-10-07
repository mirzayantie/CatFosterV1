//
//  Post.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 03/10/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase

class Post {
    
    
    var imageDownloadURL: String?
    private var image: UIImage!
    
    init(image:UIImage) {
        self.image = image
    }
    
    func save() {
        //1. create a new database reference
        
        let newCatInfo = Database.database().reference().child("cat").childByAutoId()
        let newCatKey = newCatInfo.key
        
        //convert the image to data
        if let imageData = UIImage().jpegData(compressionQuality: 0.6) {
            //2. create a new storage reference
            let imageStorageRef = Storage.storage().reference().child("images")
            let newImageRef = imageStorageRef.child(newCatKey!)
            print("in save")
            //3. save the image to storage first
            newImageRef.putData(imageData).observe(.success) { (snapshot) in
                // save the catInfo and image
                print(snapshot)
                newImageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!)
                        return
                    } else {
                    //on sucess get the url
                    self.imageDownloadURL = url?.absoluteString
                     // create an array of data to post to database
                        let newCatPostDictionary = [
                            "imageDownload" : self.imageDownloadURL
                        ]
                        print(newCatPostDictionary)
                        newCatInfo.setValue(newCatPostDictionary)
                    }
                }) //end of downloadurl
                
            } //end of putData
        
    } // end of convert image to data
  
} // end of save
}
