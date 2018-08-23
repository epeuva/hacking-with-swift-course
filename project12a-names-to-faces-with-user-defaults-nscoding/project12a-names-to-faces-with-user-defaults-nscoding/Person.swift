//
//  Person.swift
//  project12a-names-to-faces-with-user-defaults-nscoding
//
//  Created by epeuva on 22/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

// Conform NSCoding protocol in order to be able to save it to UserDefaults
class Person: NSObject, NSCoding {
    
    // Those two properties must have a value, because they are not optional (!, ?)
    var name: String
    var image: String
    

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    // Mandatory to conform with NSCoding protocol
    // Used when saving objects to UserDefaults
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    
    // Mandatory to conform with NSCoding protocol
    // required keyword. all subclasses are required to implement this method
    // Used when loading objects from UserDefaults.
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
    }

}
