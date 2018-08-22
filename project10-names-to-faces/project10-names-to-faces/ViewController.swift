//
//  ViewController.swift
//  
//
//  Created by epeuva on 22/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

// Class supports two protocols: UIImagePickerControllerDelegate, UINavigationControllerDelegate
class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds an add button to the navigation controller
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    
    /// Adds a person to the application
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true // Allows the user to edit (crop, ...) the photo
        picker.delegate = self
        present(picker, animated: true)
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

    
    // Function called when the user has selected an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Ensure that we get an UIImage as a parameter
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        // Generates a random UUID: Universally Unique Identifier
        let imageName = UUID().uuidString
        
        // Gets the documents directory (private app folder) and appends the image name to it
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // Tries to convert an UIImage to a Data object in order to be able to save it to the disk
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true)
    }
    
    
    /// Gets the user documents directory URL in order to save private information for the app
    ///
    /// - Returns: URL having the user's documents directory
    func getDocumentsDirectory() -> URL {
        // Documents directory relative to the users home directory. Has an array with one thing: The user's documents directory.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    
    
    
}

