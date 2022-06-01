//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
   
    let db = Firestore.firestore()
    var message = [Message]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMessages()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        title = K.appName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            makeAlert(title: "Oops", message: signOutError as! String)
//          print("Error signing out: %@", signOutError)
        }
    }
    func makeAlert (title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        let dateNow = Date().timeIntervalSince1970
//        messageTextfield.text? = ""
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSender,K.FStore.bodyField:messageBody,K.FStore.dateField:dateNow]) { error in
                if error != nil {
                    self.makeAlert(title: "error saving data", message: error!.localizedDescription)
                }else {
//                    print("data saved succsefully")
                    self.messageTextfield.text = ""
                }
            }
        }
        
    }
    func fetchMessages (){
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, err) in
            self.message = []
            if let err = err {
                self.makeAlert(title: "Error getting documents", message: err.localizedDescription)
            } else {
                if let QuerysnapShot = querySnapshot?.documents {
                    for document in QuerysnapShot {
                        let data = document.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                          
                            let messageSent = Message(sender: messageSender, body: messageBody)
                            self.message.append(messageSent)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: IndexPath(row: self.message.count - 1, section: 0), at: .top, animated: true)
                            }
                           
                        }
                       
                    }
                }
               
            }
        }
    }
}
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
      
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell",for: indexPath) as! MessageCellTableViewCell
        let userLogeedIn = Auth.auth().currentUser?.email
        let message = message[indexPath.row]
        cell.label.text = message.body
           
        
        if userLogeedIn == message.sender {
            
            cell.MessageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.rightImageView.image = UIImage(named:"MeAvatar")
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
        }else {
            cell.label.text = message.body
            cell.MessageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.leftImageView.image = UIImage(named:"YouAvatar")
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
        }
        
            return cell
        
    
    }

}
