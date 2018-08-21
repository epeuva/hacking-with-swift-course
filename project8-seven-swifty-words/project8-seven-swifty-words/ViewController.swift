//
//  ViewController.swift
//  
//
//  Created by epeuva on 21/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        // Changed observer
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // That's why we add 1001 tag to every button... in order to retrieve all UIButtons and be able to attach a method to the click event.
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped),for: .touchUpInside)
        }
        
        loadLevel()
    }

    
    /// Used in UIButton tab #selector to retrieve the button tapped
    ///
    /// - Parameter btn: the button tapped
    @objc func letterTapped(btn: UIButton) {
        
        // Clear Tap letters to guess message the first button tapped
        if activatedButtons.count == 0 {
            currentAnswer.text = ""
        }
        
        // Append button text to the current answer
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        
        // Buttons that the user has tapped
        activatedButtons.append(btn)
        btn.isHidden = true
    }
    
    
    /// Removes the text from the current answer. Unhides all buttons.
    ///
    /// - Parameter sender: the button that called the clearTapped event
    @IBAction func clearTapped(_ sender: Any) {
        currentAnswer.text = "Tap letters to guess"
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        activatedButtons.removeAll()
    }

    
    @IBAction func submitTapped(_ sender: Any) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            var splitAnswers = answersLabel.text!.components(separatedBy: "\n")
            splitAnswers[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitAnswers.joined(separator: "\n")
            currentAnswer.text = "Tap letters to guess"
            score += 1
            
            // If score is 7, we could go to the next game level
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
        
    }
    
    
    /// Increases the level of the current game.
    ///
    /// - Parameter action: UIAlertAction that produced this event (from UIAlertController)
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                // .enumerated() used in order to know the position of each item.
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    clueString += "\(index + 1). \(clue)\n"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        // Remove new lines and spaces
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        if letterBits.count == letterButtons.count {
            // "..<" half-open range operator: do not include the upper limit
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }

    }


}

