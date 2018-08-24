//
//  ViewController.swift
//  
//
//  Created by epeuva on 24/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tap: UIButton!
    
    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Loads the resource "penguin" as an iname
        imageView = UIImageView(image: UIImage(named: "penguin"))
        
        // Centers the penguin
        imageView.center = CGPoint(x: 512, y: 384)
        
        // Adds the penguin image to the imageView
        view.addSubview(imageView)
        
    }

    @IBAction func tapped(_ sender: Any) {
        
        // Hide the tap button
        tap.isHidden = true
        
        // Animate with 1 second, without delay
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:
            { [unowned self] in // avoid strong references
                switch self.currentAnimation {
                case 0:
                    // Animation for 2x default size. (default with ease in / ease out)
                    self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                    break
                case 1:
                    // Clears any applied transforms
                    self.imageView.transform = CGAffineTransform.identity
                    break;
                case 2:
                    // Moves the image the amount of points
                    self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                case 3:
                    self.imageView.transform = CGAffineTransform.identity
                case 4:
                    // Rotation transform
                    self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                case 5:
                    self.imageView.transform = CGAffineTransform.identity
                case 6:
                    // Alpha and backgrund color transform
                    self.imageView.alpha = 0.1
                    self.imageView.backgroundColor = UIColor.green
                case 7:
                    self.imageView.alpha = 1
                    self.imageView.backgroundColor = UIColor.clear
                default:
                    break
                }
        }) { [unowned self] (finished: Bool) in //
            
            // Show the tap button
            self.tap.isHidden = false
        }

        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
}
