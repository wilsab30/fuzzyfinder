//
//  PetDetailsViewController.swift
//  FuzzyFinder
//
//  Created by Sabrina Wilbert on 1/16/17.
//  Copyright © 2017 Sabrina Wilbert. All rights reserved.
//

import UIKit

class PetDetailsViewController: UIViewController {

    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var detailName: UILabel!
    
    @IBOutlet var detailAge: UILabel!
    
    @IBOutlet var detailDescription: UITextView!
    
    var sentData1: String!
    var sentData2: String!
    var sentData3: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailName.text = sentData1
        detailAge.text = sentData2
        detailImageView.image = UIImage(named: sentData3)
        
        self.navigationItem.title = sentData1
        
        if detailName.text == "Birdie" {
        
            detailDescription.text = "the sweetest dog ever"
        }
        
        if detailName.text == "Sammy"{
            
            detailDescription.text = "very shy but sweet"
        }
        
        if detailName.text == "Kao"{
            
            detailDescription.text = "will bite, don't approach"
        }



        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
