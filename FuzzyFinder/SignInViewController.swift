//
//  SignInViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/5/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var submitCancelSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func submitButton(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in!")
            if error != nil {
                print("We have an error:\(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user!")
                    if error != nil {
                        print("We have an error:\(error)")
                    } else {
                        print("User created succesfully")
                        self.performSegue(withIdentifier: "ownerProfile", sender: nil)
                    
                    }
                })
                
            } else {
                print("Signed in succesfully")
                self.performSegue(withIdentifier: "ownerProfile", sender: nil)
                
            }
        })
    }
    
    
    
}
