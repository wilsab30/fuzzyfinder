//
//  PetDetailsViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/16/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import Firebase

class PetDetailsViewController: UIViewController {

    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var detailName: UILabel!
    
    @IBOutlet var detailAge: UILabel!
    
    
    @IBOutlet var detailBreed: UILabel!
    
    @IBOutlet var detailDescription: UITextView!
    
    var sentData1: String!
    var sentData2: String!
    var sentData3: String!
    var sentData4: String!
    var sentData5: String!
    
    var ref: FIRDatabaseReference?
    var refhandle: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        detailName.text = sentData1
//        detailAge.text = sentData2
//        detailImageView.image = UIImage(named: sentData3)
//
//        self.navigationItem.title = sentData1
//        
//        if detailName.text == "Birdie" {
//        
//            detailDescription.text = "the sweetest dog ever"
//        }
//        
//        if detailName.text == "Sammy"{
//            
//            detailDescription.text = "very shy but sweet"
//        }
//        
//        if detailName.text == "Kao"{
//            
//            detailDescription.text = "will bite, don't approach"
//        }
    
        ref = FIRDatabase.database().reference()


        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        ref?.child("owner_profiles").child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let d = (snapshot.value! as? NSDictionary)
            let profiles = d?["pet_profiles"] as? NSDictionary
            for profile in profiles!{
                let profile_value = profile.value as! NSDictionary
            let sentData1 = profile_value["petName"]! as! String
            let sentData2 = profile_value["petAge"]! as! String
            let sentData3 = profile_value["petDescription"]! as! String
            let sentData4 = profile_value["petBreed"]! as! String
            
            
                    self.navigationItem.title = sentData1
                    self.detailAge.text = sentData2
                    self.detailDescription.text = sentData3
                    self.detailBreed.text = sentData4
                    self.detailImageView.image = UIImage(named: self.sentData5)
            
            }
            
            
            
            })
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
