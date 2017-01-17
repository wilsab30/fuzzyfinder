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
    
    
    @IBOutlet var submitButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
//        submitButton.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(petPicImageView.image!, 0.1)!
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            
            print("We tried to upload")
            if error != nil {
                print("We had an error\(error)")
            }
        })

        
//        dismiss(animated: true, completion: nil)
        
    }
    
    

    

}
