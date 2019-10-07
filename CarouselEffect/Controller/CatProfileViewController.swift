//
//  CatProfileViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 17/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import DynamicColor

class CatProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var searchController: UISearchController!

    @IBOutlet weak var showAllButton: UIButton!
    @IBOutlet weak var welcomeMessage: UILabel!
    
   // var catProfile : [CatProfile] = [CatProfile]()
    var cat : [Cat] = [Cat]()
    var ref: DatabaseReference!
    let cellScale : CGFloat = 0.6
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundColor = DynamicColor(hex: 0xDFF0EA)
        self.view.backgroundColor = backgroundColor
        self.collectionView.backgroundColor = backgroundColor
        
        // add activity indicator
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
       
        self.view.addSubview(activityIndicator)
        
        ref = Database.database().reference()
        activityIndicator.startAnimating()
        checkIfUserIsLoggedIn()
        
        setupCollectionView()
        
        loadCatList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("willappear")
        
    }
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser != nil {
            
            // User is signed in.
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("user").child(uid!).observe(DataEventType.value, with: { (snapshot) in
             
                let value = snapshot.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                self.activityIndicator.stopAnimating()
                self.welcomeMessage.text = "Hello \(name)"
                
                
            }, withCancel: nil)
            
        } else {
            print("No user is signed in")
        }
    }
    
    func setupCollectionView() {
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth)/2.0
        let insetY = (view.bounds.width - cellHeight)/2.0
        
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: Private Methods. load from server
    private func loadCatList() {
        //access firebase database
        activityIndicator.startAnimating()
        let catRef = ref.child("cat")
        //read data
        catRef.observe(DataEventType.value, with: { (snapshot) in
            //clear local data
            self.cat = []
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            //print("Amount of data from server \(postDict.count)")
            var catName = ""
            var catImageURL = ""
            var catAge = ""
            var catGender = ""
            var catBreed = ""
            var catDescription = ""
            var catAddInfo = ""
            var catColour = ""
            
            for (key, value) in postDict {
                print("\(key) -> \(value)")
                
                catName = value["name"] as! String
                catImageURL = value["photo"] as? String ?? ""
                catBreed = value["breed"] as! String
                catAge = value["age"] as! String
                catGender = value["gender"] as! String
                catColour = value["colour"] as! String
                catDescription = value["description"] as! String
                catAddInfo = value["otherInfo"] as! String
                
                let cats = Cat(catName: catName, catImageURL: catImageURL, catBreed: catBreed, catAge: catAge, catGender: catGender, catDescription: catDescription, catColour: catColour, additionalInfo: catAddInfo)
    
                self.cat += [cats]
                
                //print("Amount of data from local \(self.catList.count)")
            }
            self.activityIndicator.stopAnimating()
            //reload local data when get data from server
            self.collectionView.reloadData()
            
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //pass data to detailcat view controller.
        let detailCatController = storyboard?.instantiateViewController(withIdentifier: "DetailCatInfoController") as? DetailCatInfoController
        
        detailCatController?.getCatName = cat[indexPath.row].catName
        detailCatController?.getCatAge = cat[indexPath.row].catAge
        detailCatController?.getCatColour = cat[indexPath.row].catColour
        detailCatController?.getCatBreed = cat[indexPath.row].catBreed
        detailCatController?.getCatGender = cat[indexPath.row].catGender
        detailCatController?.getCatDescription = cat[indexPath.row].catDescription
        detailCatController?.getCatAddInfo = cat[indexPath.row].additionalInfo
        
        let url = URL(string: cat[indexPath.row].catImageURL)
        // convert url to image
        KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil ) { (image, error, cache, url) in
            
            detailCatController?.getCatImage = image!
            
            self.navigationController?.pushViewController(detailCatController!, animated: true)
        }
    }
   
    
    //MARK : UICollectionViewDataSource method
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCollectionViewCell", for: indexPath) as! CatCollectionViewCell
        
        let Cat = cat[indexPath.row]
        cell.catProfile = Cat
        return cell
        
    }
    
    //MARK : UIScrollViewDelegate method...what this line of code do???
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellWidthIncludingSpacing = layout.itemSize.width - layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "login", sender: self)
            //navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("error: there was a problem logging out")
        }
        
    }
    
    
    @IBAction func showAllButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ShowAllCats", sender: self)
        
    }
    
   
}
