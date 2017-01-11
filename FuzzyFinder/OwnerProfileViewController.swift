//
//  OwnerProfileViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/7/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class OwnerProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func logoutTouched(_ sender: Any) {
        
        let KeychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("Keychain removed")
        dismiss(animated: true, completion: nil)
    }
  

}
