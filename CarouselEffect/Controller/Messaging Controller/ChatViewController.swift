//
//  ChatViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 18/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // Declare instance variables here
    var messageArray: [Message] = [Message]()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var attachPicture: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    var topButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate of the table view here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
       
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell")
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tableViewTapped))
        
        messageTableView.addGestureRecognizer(tapGesture)
        
        configureTableView()
        
        retrieveMessages()
        
        messageTableView.separatorStyle = .none
        
        
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody

        cell.avatarImageView.image = UIImage(named: "kitten")

        if cell.senderUsername.text == Auth.auth().currentUser?.email! {

            //Set background to blue if message is from logged in user.
            //cell.avatarImageView.backgroundColor = UIColor.blue
            cell.messageBackground.backgroundColor = UIColor.brown

        } else {

            //Set background to grey if message is from another user.
            //cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.gray
        }
        
        return cell
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
    
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
        
    }
    
    //MARK: - TextField Delegate Methods
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Send & Recieve Messages from Firebase
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
//        let messagesDB = Database.database().reference(fromURL: "https://flash-chat-e266a.firebaseio.com/").child("Messages")
//        let values = ["email": messageTextfield.text, "message": ]
//        messagesDB.updateChildValues(values, withCompletionBlock: { (error, ref) in
//            if error != nil {
//                print(error!)
//                return
//            }
//            print("Saved user successfully into Firebase database")
//        })
//        print ("Register is successful!")
//
        let messagesDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextfield.text!]
        
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Message saved successfully!")
            }
            
            self.messageTextfield.isEnabled = true
            self.sendButton.isEnabled = true
            self.messageTextfield.text = ""
            
            
        }
        
        
    }
    
    
    func retrieveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            
            self.configureTableView()
            self.messageTableView.reloadData()
            
            
            
        }
}
}
