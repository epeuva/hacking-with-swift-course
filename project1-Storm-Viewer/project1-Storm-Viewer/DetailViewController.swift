//
//  DetailViewController.swift
//  project1-Storm-Viewer
//
//  Created by epeuva on 01/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // @IBOutlet: connection between this line of code and Interface Builder.
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?
    
    // when the view is about to be shown: viewWillAppear()
    // when it has been shown: viewDidAppear()
    // when it's about to go away: viewWillDisappear()
    // when it has gone away: viewDidDisappear()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title that will be used in Navigator Bar
        // !!! Both are optional strings !!!∫
        title = selectedImage

        // If there is any selectedImage, load the UIImage with the name of the image file
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
    }
    
    // Hide Navigation Bar just before the view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    // Show Navigation Bar just before the view will disapear (MANDATORY for not breaking things)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
