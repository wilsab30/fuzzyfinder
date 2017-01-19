//
//  OwnerInfoViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/18/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import Firebase

class OwnerInfoViewController: UIViewController {
    
    
    @IBOutlet var firstName: UITextField!
    
    @IBOutlet var lastName: UITextField!
    
    @IBOutlet var crossStreet: UITextField!
    
//    @IBOutlet var firstName: UITextField!
//    @IBOutlet var lastName: UITextField!
//    @IBOutlet var crossStreet: UITextField!
    var ref: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitOwnerInfo(_ sender: Any) {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref?.child("owner_profile").child(userID!)
        ref?.child("owner_profiles").child("users").child(userID!).child("firstName").setValue(firstName.text)
        ref?.child("owner_profiles").child("users").child(userID!).child("lastName").setValue(lastName.text)
        ref?.child("owner_profiles").child("users").child(userID!).child("crossStreet").setValue(crossStreet.text)
        
        dismiss(animated: true, completion: nil)
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
