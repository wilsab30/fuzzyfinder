//
//  MessagesViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/14/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var messageTableView: UITableView!
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var postData = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self

        // set firebase reference
        ref = FIRDatabase.database().reference()
        
        //retrieve post and listen for changes
        databaseHandle = ref?.child("Post").observe(.childAdded, with: { (snapshot) in
            // code to execute when child is added to "Posts"
            //take values from snapshot and add it to postData array
            //try to convert value of snapshot to string
            let post = snapshot.value as? String
            //conditionally bind- if there is a string set actualPost to it
            if let actualPost = post {
            //add post to postData array
                self.postData.append(actualPost)
                self.messageTableView.reloadData()
            
            }
            
        })
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }

    
    
    
    @IBAction func messageDismiss(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    

}
