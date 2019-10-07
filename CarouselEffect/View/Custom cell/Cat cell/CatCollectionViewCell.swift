//
//  CatCollectionViewCell.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 17/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Kingfisher

class CatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var catTitleLabel: UILabel!
    
    var catProfile: Cat! {
        didSet {
            getCat()
            updateUI()
        }
    }
    
    func updateUI() {
//        if let catProfile = catProfile {
//            //featuredImageView.image = catProfile.catImageURL.abs
//            catTitleLabel.text = catProfile.catName
//            //backgroundColorView.backgroundColor =
//        } else {
//            featuredImageView.image = nil
//            catTitleLabel.text = nil
//            backgroundColorView.backgroundColor = nil
//        }
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
        featuredImageView.layer.cornerRadius = 10.0
        featuredImageView.layer.masksToBounds = true
    }
    
    func getCat() {
   
                let url = URL(string: catProfile.catImageURL)
                // this output an image
                KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil ) { (image, error, cache, url) in
                    
                    self.featuredImageView.image = image
                    self.featuredImageView.kf.indicatorType = .activity
                    self.catTitleLabel.text = self.catProfile.catName
                }
            //}
       // }
    }
    
}
