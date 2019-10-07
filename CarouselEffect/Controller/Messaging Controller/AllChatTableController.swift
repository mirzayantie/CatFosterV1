//
//  AllChatTableController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 23/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase

class AllChatTableController: UITableViewController {
    
    //to change user to Chatlist
    var users : [User] = [User]()
    
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.register(UINib(nibName: "CustomAllChatCell", bundle: nil) , forCellReuseIdentifier: "AllChatCell")
        
        //configNavigationBar()
        
        checkIfUserIsLoggedIn()
        
        //TODO : To fetch chatlist which contain date, sender name, titleofmessage, profile image and message body.
        fetchUser()
    }
    
    
    func configNavigationBar() {
        
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        
        // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.white
        //navigationBar.barTintColor = UIColor(red: 44/255, green: 54/255, blue: 63/255, alpha: 1)
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "All Messages"
        
        //Back button logged user off to login page
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
    }
    
    @objc func handleBack() {
        
        dismiss(animated: true, completion: nil)
    }
    
    //TODO : Fetch chat/messages list from database
    func fetchUser() {
        
        Database.database().reference().child("users").observe(.value, with: { (snapshot) in
            let dictionary = snapshot.value as? [String:AnyObject] ?? [:]
            
            //if use this setter, app will crash if class properties don't exactly match up with the firebase dictionary keys
            //user.setValuesForKeys(dictionary)
            
            //try use different way
            var senderName = ""
            var email = ""
           
            let user = User()
            
            for (_, value) in dictionary {
                //print(value["name"])
                senderName = value["name"] as! String
                email = value["email"] as! String
               
                self.users.append(user)
                //print("data fetch \(self.users.count)")
                print(senderName)
                print(email)
                
            }
            
            self.tableView.reloadData()
            
            
        }, withCancel: nil)
    }

    
    // TO REVISIT : UID come out different to what have been saved in database!!!!
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser != nil {
            // User is signed in.
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    // ???????????????????not functioning yet..result is nil because it looks for  different uid then saved in firebase.
                    self.navigationItem.title = dictionary ["name"] as? String
                    print(snapshot)
                }
            }, withCancel: nil)
            
        } else {
            // No user is signed in.
            // ...
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllChatCell", for: indexPath) as! CustomAllChatCell
        let user = users[indexPath.row]
        cell.senderName.text = user.name
        cell.titleOfMessage.text = user.email
        // Configure the cell...
        
        return cell
    }
    
    
    
}
