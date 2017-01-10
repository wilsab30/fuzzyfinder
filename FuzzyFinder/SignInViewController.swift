//
//  SignInViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/5/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class SignInViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var submitCancelSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.readPermissions = ["email","user_friends"]
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with Facebook")
        
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
