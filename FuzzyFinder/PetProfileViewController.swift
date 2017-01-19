//
//  PetProfileViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/7/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit
import Firebase

class PetProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var petPicImageView: UIImageView!
    
    @IBOutlet var petName: UITextField!
    
    
    @IBOutlet var petBreed: UITextField!
    
    @IBOutlet var petDescription: UITextField!
    
    @IBOutlet var petAge: UITextField!
    
    @IBOutlet var submitButton: UIButton!
     var ref: FIRDatabaseReference?
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = FIRDatabase.database().reference()
        
        imagePicker.delegate = self
    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        petPicImageView.image = image
        
        petPicImageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        

    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func addPetProfile(_ sender: Any) {
        
        submitButton.isEnabled = false
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        self.ref?.child("owner_profile").child(userID!)
        self.ref?.child("owner_profiles").child("users").child(userID!).child("pet_profiles").childByAutoId()
        self.ref?.child("owner_profiles").child("users").child(userID!).child("pet_profiles").child("petName").setValue(self.petName.text)
        self.ref?.child("owner_profiles").child("users").child(userID!).child("pet_profiles").child("petAge").setValue(self.petAge.text)
        self.ref?.child("owner_profiles").child("users").child(userID!).child("pet_profiles").child("petBreed").setValue(self.petBreed.text)
        self.ref?.child("owner_profiles").child("users").child(userID!).child("pet_profiles").child("petDescription").setValue(self.petDescription.text)
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(petPicImageView.image!, 0.1)!

        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            
            print("We tried to upload")
            if error != nil {
                print("We had an error\(error)")
            }
            
            
        })

        
       dismiss(animated: true, completion: nil)
        
    }
    
    

    

}
