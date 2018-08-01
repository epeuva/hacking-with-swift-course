//
//  ViewController.swift
//  
//
//  Created by epeuva on 01/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // Properties
    var pictures = [String]() // [String] “an array of strings”; () “create a new array”
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Data  type that lets us work with the filesystem
        let fm = FileManager.default
        
        //  Resource path of our app's bundl
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // This picture to load
                pictures.append(item)
            }
        }
        
        print(pictures)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
