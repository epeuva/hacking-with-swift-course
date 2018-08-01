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
        
        // Enable large titles across the app (see: iOS 11 revamped Apple’s design guidelines for first view)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Title that will be used in Navigator Bar
        title = "Storm Viewer"
        
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
    
    // How many rows should be shown.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // Handle table view row click (See extended explanation on page 138)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    // Lazy loading table views rows (like an infinite scroll)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        // Put the label of the cell as the picture name
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

}
