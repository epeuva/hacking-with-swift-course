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

        // Try to load the words of the start.txt file
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
        } else {
            allWords = defaultWords
        }
        
        print(allWords)
        
        startGame()
    }
    
    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

}

