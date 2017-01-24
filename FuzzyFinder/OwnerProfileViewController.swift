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
import SDWebImage


class OwnerProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var imageList = [Data]()
    var imageUrlList = [String]()
    var nameList = [String]()
    var ageList = [String]()
    var descriptionList = [String]()
    var petNameData: String!
    var petAgeData: String!
    var downloadUrl: URL!
    var url: String!
    
    
    
    
     var ref: FIRDatabaseReference?
     var refhandle: UInt!
    @IBOutlet weak var tableView: UITableView!
    
    
    var ownerProfiles = [OwnerData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 2
        
        
        ref = FIRDatabase.database().reference()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
       getData()
    }
    
    
    

    
    
    func getData() {
    
        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        ref?.child("owner_profiles").child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
        
           let d = snapshot.value! as? NSDictionary
          let profiles = d?["pet_profiles"] as? NSDictionary
            if profiles != nil {
            for profile in profiles!{
            let profile_value = profile.value as! NSDictionary
            self.nameList.append(profile_value["petName"] as! String!)
            self.ageList.append(profile_value["petAge"] as! String!)
            self.url = profile_value["petImageUrl"] as! String!
               if let downloadUrl = URL(string: self.url!) {
                    do {
                        let imageData = try Data(contentsOf: downloadUrl)
                        self.imageList.append(imageData)
                    } catch {
                        print("contents could not be loaded")
                    }
                } else {
                    print("the URL was bad!")
                }
                
                }
            self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetTableViewCell
        cell.cellName.text = nameList[indexPath.row]
        cell.cellAge.text = ageList[indexPath.row]
        
        cell.imageView?.image = UIImage.sd_image(with: imageList[indexPath.row])
        cell.cellName.textColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameList.count
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
                
//                let image = imageList[IndexPath.row]
//                DVC.sentData5 = image
                
            }
        }
    }
    
    
        
    
    
    
}

    
