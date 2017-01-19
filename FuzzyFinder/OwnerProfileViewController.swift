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


class OwnerProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var imageList = ["birdie.jpg","birdie.jpg","birdie.jpg"]
    var nameList = ["Birdie", "Sammy", "Kao"]
    var ageList = ["5", "3", "2"]
    var descriptionList = ["the sweetest dog ever", "very shy, but sweet", "Will bite, don't approach"]
    
    
     var ref: FIRDatabaseReference?
    @IBOutlet weak var tableView: UITableView!
    
    
    var ownerProfiles = [OwnerData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 2
        
        ref = FIRDatabase.database().reference()
//        DataService.ds.REF_OWNER_PROFILE.observe(.value, with: { (snapshot) in
//            
//            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
//            
//                for snap in snapshot {
//                
//                    print("Snap\(snap)")
//                    if let ownerDataDict = snap.value as? Dictionary<String, Any>{
//                        let key = snap.key
//                        let owner_profile = OwnerData(ownerProfileId: key, ownerProfileData: ownerDataDict)
//                        self.ownerProfiles.append(owner_profile)
//                    
//                    }
//                
//                }
//            
//            }
//        })
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        
    }
    

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetTableViewCell
        
        cell.cellName.text = nameList[indexPath.row]
        cell.cellAge.text = ageList[indexPath.row]
        cell.imageView?.image = UIImage(named: imageList[indexPath.row])
        cell.cellName.textColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
        
        return cell
    }

    
    @IBAction func logoutTouched(_ sender: Any) {
        
        _ = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Keychain removed")
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showDetail"){
            let DVC = segue.destination as! PetDetailsViewController
            
            if let IndexPath = self.tableView.indexPathForSelectedRow {
                
                let name = nameList[IndexPath.row] as String
                DVC.sentData1 = name
                
                let age = ageList[IndexPath.row] as String
                DVC.sentData2 = age
                
                let image = imageList[IndexPath.row]
                DVC.sentData3 = image
                
            }
        }
    }
    
    
        
    
    
    
}

    
