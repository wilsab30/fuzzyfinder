//
//  DataService.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/9/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = FIRDatabase.database().reference()

let STORAGE_BASE = FIRStorage.storage().reference()


class DataService {

    static let ds = DataService()
    
    //DB references
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_PET_PROFILES = DB_BASE.child("pet_profiles")
    private var _REF_OWNER_PROFILE = DB_BASE.child("owner_profile")
    private var _REF_MESSAGES = DB_BASE.child("messages")
    
    //Storage refences
    private var _REF_PET_PROFILE_IMAGES = STORAGE_BASE.child("images")
    
    var REF_BASE: FIRDatabaseReference {
    
        return _REF_BASE
    }
    
    var REF_USERS: FIRDatabaseReference {
        
        return _REF_USERS
    }
    
    var REF_PET_PROFILES: FIRDatabaseReference {
        
        return _REF_PET_PROFILES
    }
    
    var REF_OWNER_PROFILE: FIRDatabaseReference {
        
        return _REF_OWNER_PROFILE
    }
    

    
    var REF_MESSAGES: FIRDatabaseReference {
        
        return _REF_MESSAGES
    }
    
    var REF_PET_PROFILE_IMAGES: FIRStorageReference {
    
        return _REF_PET_PROFILE_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    
    }


}
