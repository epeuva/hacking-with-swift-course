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
    
    var people = [Person]()

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
        return people.count
    }
    
    
    // Number of items in the UICollectionView (placeholder at this moment)
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create a view cell based on the created UICollectionViewCell Person
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell // Typecast to PersonCell
        
        // get the People object based on UICollectionView current index
        let person = people[indexPath.item]
        
        // get the name
        cell.name.text = person.name
        // get the image path
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        
        // Get the UIImage and apply a rounded border color using CALayer & CGColor
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0,blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    
    /// Allows the user to edit the Person name when tapping a cell
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        // Creates an UIAlert in order to be able to rename a person name
        let ac = UIAlertController(title: "Rename person", message:nil, preferredStyle: .alert)
        
        ac.addTextField() // adds an input text field in order to be able to edit the Person name
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default)
            { [unowned self, ac] _ in
                let newName = ac.textFields![0]
                person.name = newName.text!
                self.collectionView?.reloadData()
            }
        )
        
        present(ac, animated: true)
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
        
        // Adds the new person to the people array and reload the collectionView
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView?.reloadData()
        
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

