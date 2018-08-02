//
//  ViewController.swift
//  
//
//  Created by epeuva on 02/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit
import GameplayKit // Random order

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    /* Defining variables using  "type inference" */
    // Array of countries
    var countries = [String]()
    
    // Game Score
    var correctAnswer = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCountries()
        
        // Configure buttons (CALayer)
        // Border
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // Border color
        // Could be also been done by:
        // UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askQuestion() {
        
        // Randomize de order of the array using the GameplayKit
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as![String]
        
        // .normal  refers to "the normal value of UIControlState."
        // See Page 165 (book) for more info.
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        // Generates a random number from 0 to upperBound (3)
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        // Adds the uppercased correct answer country name to the navigation bar title
        title = countries[correctAnswer].uppercased()
    }
    
    /// Loads the default counties for the game
    func loadCountries(){
        //Method 1:
        /*countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")*/
        
        // Method 2:
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
 
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
    }
    
    
    

}

