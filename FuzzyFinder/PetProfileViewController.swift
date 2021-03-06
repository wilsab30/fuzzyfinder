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
    
    var petImageUrl: Any!
    
    @IBOutlet var submitButton: UIButton!
    var imageUrl: FIRStorageReference?
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
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func addPetProfile(_ sender: Any) {
        
        submitButton.isEnabled = false
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        

        
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(petPicImageView.image!, 0.1)!
//        let metaData = FIRStorageMetadata()
//        metaData.contentType = "image/jpg"

        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            
            let downloadURL = metadata!.downloadURL()
            let downloadString = downloadURL?.absoluteString
            if error != nil {
                print("We had an error\(error)")
            } else {
//            let downloadURL = metaData.downloadURL()!.absoluteString
            let newProfile = self.ref?.child("owner_profiles").child("users").child(userID!).child("pet_profiles").childByAutoId()
            newProfile?.child("petName").setValue(self.petName.text)
            newProfile?.child("petAge").setValue(self.petAge.text)
            newProfile?.child("petBreed").setValue(self.petBreed.text)
            newProfile?.child("petDescription").setValue(self.petDescription.text)
            newProfile?.child("petImageUrl").setValue(downloadString)
            }
        })

    
       dismiss(animated: true, completion: nil)
    
        
    }
    
    
    @IBAction func petNameDismiss(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    
    @IBAction func petAgeDismiss(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    
    @IBAction func petBreed(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    
    
    
    @IBAction func petDescriptionDismiss(_ sender: Any) {
        self.resignFirstResponder()
    }
    

    

}//End of class
