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
    
    
    
    
    var ownerProfiles = [OwnerData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    
    @IBAction func logoutTouched(_ sender: Any) {
        
        let KeychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("Keychain removed")
        dismiss(animated: true, completion: nil)
    }
  

    @IBOutlet var listPetProfiles: [UITableView]!
}
