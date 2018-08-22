//
//  ViewController.swift
//  
//
//  Created by epeuva on 22/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds an add button to the navigation controller
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    
    /// Adds a person to the application
    @objc func addNewPerson() {
    }
    
    
    // Number of items in the UICollectionView (placeholder at this moment)
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // Number of items in the UICollectionView (placeholder at this moment)
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create a view cell based on the created UICollectionViewCell Person
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell // Typecast to PersonCell
        return cell
    }

    
    
    
}

