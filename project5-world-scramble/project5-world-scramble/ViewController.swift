//
//  ViewController.swift
//  
//
//  Created by epeuva on 02/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    
    // All the words from the star.txt file
    var allWords = [String]()
    
    // Words used in game
    var usedWords = [String]()
    
    // Default words
    var defaultWords = ["silkworm"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add button in navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        // Try to load the words of the start.txt file
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
        } else {
            allWords = defaultWords
        }
        
        startGame()
    }
    
    
    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    // Count the table view rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    
    // Lazy loading table views rows with used words
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    
    /// Opens an UIAlertController with a textField in order to let the user write and submit a word
    @objc func promptForAnswer() {
        // UIAlertController creation
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        
        // Adds an editable text input field to the UIAlertController
        ac.addTextField()
        
        // Similar code with normal closure syntax
        // UIAlertAction(title: "Continue", style: .default, handler: { CLOSURE CODE HERE })
        
        // Trailing closure syntax (method expecting a closure as its final parameter)
        // UIAlertAction(title: "Continue", style: .default) { CLOSURE CODE HERE }
 
        // Trailing closure syntax
        let submitAction = UIAlertAction(title: "Submit", style: .default)
            { // Trailing closure
                // Specify swift that you don't want strong references
                // use/reference self and ac inside the closure, but do not use them as strong references
                [unowned self, ac] (action: UIAlertAction) /* <-- Definition of the closure */ in /* closure code --> */
                let answer = ac.textFields![0] // read the editable text field, unwrapping the array of textfields (optional)
                // self is required in order to call submit when the closure gets executed
                self.submit(answer: answer.text!)
            }
        
        // Add UIAlertAction to the UIAlertController
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    
    /// Handles the word submision so it could be added to the table view if:
    ///  - The word is Original, Real and Possible
    ///
    /// - Parameter answer: the word to be added
    func submit(answer: String){
        
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) && isOriginal(word: lowerAnswer) && isReal(word: lowerAnswer) {
            usedWords.insert(answer, at: 0)
            
            // gets the path of the row 0, section 0, in order to be able to insert items.
            let indexPath = IndexPath(row: 0, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)

        }

    }
    
    
    /// Return if the combination of letters is possible with the currend used main word (seed)
    ///
    /// - Parameter word: word that will be checked
    /// - Returns: if the letters/ world combination is possible with the current word (seed)
    func isPossible(word: String) -> Bool {
        return true
    }
    
    
    /// Returns if the word is original, or if it is a duplicate (!Original)
    ///
    /// - Parameter word: word that will be checked
    /// - Returns: if the word used is original (not a duplciate)
    func isOriginal(word: String) -> Bool {
        return true
    }
    
    
    /// Returns if the word is a real one.
    ///
    /// - Parameter word: word that will be checked
    /// - Returns: if the world is a real one (searchable on a dictionary)
    func isReal(word: String) -> Bool {
        return true
    }
    
}

