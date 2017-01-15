//
//  SignInViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/5/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper



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
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            print("Found Keychain")
            self.performSegue(withIdentifier: "ownerProfile", sender: nil)
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
    }
    
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Tried to create user!", error ?? "")
                return
            }
            print("Successfully logged in with our user", user ?? "")
            if let user = user {
                
                let userData = ["provider": credential.provider]
                self.completeSignIn(id: user.uid, userData: userData)
                self.performSegue(withIdentifier: "ownerProfile", sender: nil)
            
            }
            
        })
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
            return
        }
    }

    
    
    
    @IBAction func submitButton(_ sender: Any) {
        
        if let email = emailTextField.text, let pwd = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                print("We tried to sign in!")
                if error == nil {
                    print("Email user authenticated in Firebase")
                    if let user = user {
                        
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                        self.performSegue(withIdentifier: "ownerProfile", sender: nil)
                    }
                    
                    
                } else {
                
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        print("We tried to create a user!")
                            if error != nil {
                                print("We have an error:\(error)")
                        } else {
                            print("User created succesfully")
                                if let user = user {
                                    let userData = ["provider": user.providerID]
                                    self.completeSignIn(id: user.uid, userData: userData)
                                }
                            
                            self.performSegue(withIdentifier: "ownerProfile", sender: nil)
                        }
                    })
                }
            })
        }
    }
  
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
    
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
    
    }
    
    
}//end of class
                    


