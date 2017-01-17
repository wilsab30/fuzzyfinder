//
//  OwnerProfileViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/7/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase


class OwnerProfileViewController: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var crossStreet: UITextField!
     var ref: FIRDatabaseReference?
    
    
    var ownerProfiles = [OwnerData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        DataService.ds.REF_OWNER_PROFILE.observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
            
                for snap in snapshot {
                
                    print("Snap\(snap)")
                    if let ownerDataDict = snap.value as? Dictionary<String, Any>{
                        let key = snap.key
                        let owner_profile = OwnerData(ownerProfileId: key, ownerProfileData: ownerDataDict)
                        self.ownerProfiles.append(owner_profile)
                    
                    }
                
                }
            
            }
        })
        
    }

    @IBAction func submitOwnerInfo(_ sender: Any) {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
//        ref?.child("owner_profiles").child("userId").setValue(userID)
        ref?.child("owner_profiles").child("users").child(userID!).child("firstName").setValue(firstName.text)
        ref?.child("owner_profiles").child("users").child(userID!).child("lastName").setValue(lastName.text)
        ref?.child("owner_profiles").child("users").child(userID!).child("crossStreet").setValue(crossStreet.text)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutTouched(_ sender: Any) {
        
        _ = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Keychain removed")
        dismiss(animated: true, completion: nil)
    }
  

    @IBOutlet var listPetProfiles: [UITableView]!
}
