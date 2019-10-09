//
//  CatViewCell.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 24/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Kingfisher

class CatViewCell: UITableViewCell{

    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catGender: UILabel!

    
    var catModel: Cat! {
        didSet {
            catName.text = catModel.catName
            catGender.text = catModel.catGender
            
            
            let url = URL(string: catModel.catImageURL)
            // this output an image
            KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil ) { (image, error, cache, url) in
                
                self.catImage.image = image
                self.catImage.kf.indicatorType = .activity
            }
        }
    }

}
