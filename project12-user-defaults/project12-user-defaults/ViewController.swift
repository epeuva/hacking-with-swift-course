//
//  ViewController.swift
//  
//
//  Created by epeuva on 23/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Create instance of user defaults
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        /*
         Reading UserDefaults:
         - integer(forKey:) returns an integer if the key existed, or 0 if not.
         - bool(forKey:) returns a boolean if the key existed, or false if not.
         - float(forKey:) returns a float if the key existed, or 0.0 if not.
         - double(forKey:) returns a double if the key existed, or 0.0 if not.
         - object(forKey:) returns Any? so you need to conditionally typecast it to your data type.
        */
        
        // Reads the UserDefaults key "SavedArray" using Object, to get an optional array of strings that if it exists, it will be saved to readArray. Otherwise, it will be created as new
        let readArray = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
        print(readArray)
        
        // Same as above
        let readDict = defaults.object(forKey: "SavedDict") as? [String:String] ?? [String: String]()
        print(readDict)
 
    }

}
