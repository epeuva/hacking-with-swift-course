//
//  ViewController.swift
//  
//
//  Created by epeuva on 20/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// Do not show the status bar on this view controller. Caution!!: This overrides a property of UIViewController, not a method!
    //override var prefersStatusBarHidden: Bool {
    //    return true
    //}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create five UILabel
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false // Disables iOS Auto Layout constraints
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        //label1.sizeToFit() // Labels does not show without this call (Not needed with vertical layout constraint)
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false // Disables iOS Auto Layout constraints
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        //label2.sizeToFit() // Labels does not show without this call (Not needed with vertical layout constraint)
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false // Disables iOS Auto Layout constraints
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        //label3.sizeToFit() // Labels does not show without this call (Not needed with vertical layout constraint)
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false // Disables iOS Auto Layout constraints
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        //label4.sizeToFit() // Labels does not show without this call (Not needed with vertical layout constraint)
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false // Disables iOS Auto Layout constraints
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        //label5.sizeToFit() // Labels does not show without this call (Not needed with vertical layout constraint)
        
        // Add labels to the view
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        /* Auto Layout Option 1: Using VFL */
        /*
        // Dictionary of views
        let viewsDictionary = ["label1": label1, "label2": label2,
                               "label3": label3, "label4": label4, "label5": label5]
        
        let metrics = ["labelHeight": 88]
        
        for label in viewsDictionary.keys {
            // Auto Layout Visual Format Language (VFL)
            // H:       Horitzontal layout
            // |        Edge of the view (of the view controller in this case)
            // []       LabelX between the edges of the view [ xxx ]
            // The name of the label uses the diccionary keys to find out the view for each label (see page 254)
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views:viewsDictionary))
            
            // V:       Vertical Layout
            // -        Space between views (10 points by default)
            // (==88)   Size of labels = 88 (deprecated qhen using metrics, was label2(==88))
            // -(>=)    Space greater than or equal to 10
            // @999     Priority from 1 o 1000 (1000 equals to must have)
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        }
        */
        
        /* Auto Layout Option 2: Using Anchors */
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            if let previous = previous {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo:
                    previous.bottomAnchor, constant: 10).isActive = true
            }
            
            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
        
    }

}
