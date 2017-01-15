//
//  ComposeViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/14/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import Firebase

class ComposeViewController: UIViewController {

    
    @IBOutlet var textView: UITextView!
    
    var ref: FIRDatabaseReference?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
    }

       
    @IBAction func addPost(_ sender: Any) {
        //Todo: Post the data to firebase
        ref?.child("Post").childByAutoId().setValue(textView.text)
        
        //Dimiss the popover
        presentedViewController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func cancelPost(_ sender: Any) {
        
        //Dimiss the popover
        presentedViewController?.dismiss(animated: true, completion: nil)
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
