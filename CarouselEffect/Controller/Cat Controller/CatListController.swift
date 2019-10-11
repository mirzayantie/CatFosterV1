//
//  CatListController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 24/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import DynamicColor

class CatListController: UITableViewController {
    
    
    var catList = [Cat]() //all list of cat
    var ref: DatabaseReference!
    var searchCat = [Cat]() // update table list with search result
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundColor = DynamicColor(hex: 0xDFF0EA)
        self.view.backgroundColor = backgroundColor
        self.tableView.separatorStyle = .none
        navigationItem.title = "Cat List"
        navigationItem.largeTitleDisplayMode = .automatic
        ref = Database.database().reference()
        loadCatList()
        setupSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: Private Methods. load from server
    private func loadCatList() {
        
        
        let catRef = ref.child("cat")
        //read from firebase database
        catRef.observe(DataEventType.value, with: { (snapshot) in
            //clear local data
            self.catList = []
            
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            //print("Amount of data from server \(postDict.count)")
            var catName = ""
            var catImageURL = ""
            var catBreed = ""
            var catAge = ""
            var catColour = ""
            var catGender = ""
            var catDescription = ""
            var catAddInfo = ""
            
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
                
                self.catList += [cats]
                self.searchCat = self.catList
                //print("Amount of data from local \(self.catList.count)")
            }
            //reload local data when get data from server
            
            self.tableView.reloadData()
            
        })
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchCat.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "catViewCell", for: indexPath) as? CatViewCell else {
            fatalError("The dequeued cell is not an instance of CatViewCell")
        }
        
        cell.catModel = searchCat[indexPath.row]
        //cell.catName.text = cats.catName
        //cell.catImage.image = cats.catImageURL
        //cell.catGender.text = cats.catGender
        
        return cell
    }
    
    // MARK : Pass cats detail to detailCatController
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let detailCatController = storyboard?.instantiateViewController(withIdentifier: "DetailCatInfoController") as? DetailCatInfoController
        
        detailCatController?.getCatName = catList[indexPath.row].catName
        detailCatController?.getCatAge = catList[indexPath.row].catAge
        detailCatController?.getCatColour = catList[indexPath.row].catColour
        detailCatController?.getCatBreed = catList[indexPath.row].catBreed
        detailCatController?.getCatGender = catList[indexPath.row].catGender
        detailCatController?.getCatDescription = catList[indexPath.row].catDescription
        detailCatController?.getCatAddInfo = catList[indexPath.row].additionalInfo
        
        let url = URL(string: catList[indexPath.row].catImageURL)
        // convert url to image
        KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil ) { (image, error, cache, url) in
            
            detailCatController?.getCatImage = image!
            
            self.navigationController?.pushViewController(detailCatController!, animated: true)
        }
        
        //add this so that when cell gets selected it just blinked (@ deselected)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CatListController: UISearchBarDelegate {
    
    enum selectedScope : Int {
        case Breed = 0
        case Colour = 1
        case Age = 2
    }
    
    private func setupSearchBar() {
        
        searchBar.delegate = self
        
        let color = DynamicColor(hex: 0x95ADBE)
        let darkColor = DynamicColor(hex: 0x4f3a65)
        searchBar.barTintColor = darkColor
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = true
        searchBar.tintColor = color
        searchBar.scopeButtonTitles = ["Breed", "Colour", "Age"]
        //put searchbar on navigation bar
        navigationItem.titleView = searchBar
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            //searchBar is empty, show all cats
            searchCat = catList
            tableView.reloadData()
            return
        }
        filterTableView(index: searchBar.selectedScopeButtonIndex, text: searchText)
        
        tableView.reloadData()
    }
    
    func filterTableView(index : Int, text : String) {
        
        switch index {
            //enum selectedScope case 0 = Breed
        case selectedScope.Breed.rawValue:
            searchCat = catList.filter({ (cat) -> Bool in
                return cat.catBreed.lowercased().contains(text.lowercased())
                
            })
        case selectedScope.Colour.rawValue:
            searchCat = catList.filter({ (cat) -> Bool in
                return cat.catColour.lowercased().contains(text.lowercased())
            })
        case selectedScope.Age.rawValue:
            searchCat = catList.filter({ (cat) -> Bool in
                return cat.catAge.lowercased().contains(text.lowercased())
            })
            
        default:
            searchCat = catList
        }
        
    }
}
