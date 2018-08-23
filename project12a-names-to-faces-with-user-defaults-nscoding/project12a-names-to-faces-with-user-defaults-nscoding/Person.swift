//
//  Person.swift
//  project12a-names-to-faces-with-user-defaults-nscoding
//
//  Created by epeuva on 22/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    
    // Those two properties must have a value, because they are not optional (!, ?)
    var name: String
    var image: String
    

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
