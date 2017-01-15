//
//  Owner_profiles.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/11/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import Foundation

class OwnerData {

    private var _firstName: String!
    private var _lastName: String!
    private var _crossStreet: String!
    private var _imageUrl: String!
    private var _ownerProfileId: String!
    
    var firstName: String {
    
        return _firstName
    }
    
    var lastName: String {
        
        return _lastName
    }

    var crossStreet: String {
        
        return _crossStreet
    }

    var imageUrl: String {
        
        return _imageUrl
    }

    var ownerProfileId: String {
        
        return _ownerProfileId
    }

    init(firstName: String, lastName: String, crossStreet: String, imageUrl: String){
    
        self._firstName = firstName
        self._lastName = lastName
        self._crossStreet = crossStreet
        self._imageUrl = imageUrl
    }

    init(ownerProfileId: String, ownerProfileData: Dictionary<String, Any>){
        self._ownerProfileId = ownerProfileId
        
        if let firstName = ownerProfileData["firstName"] as? String{
            self._firstName = firstName
        }
        
        if let lastName = ownerProfileData["lastName"] as? String{
            self._lastName = lastName
        }

        if let crossStreet = ownerProfileData["crossStreet"] as? String{
            self._crossStreet = crossStreet
        }
        
        if let imageUrl = ownerProfileData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
    }

}
