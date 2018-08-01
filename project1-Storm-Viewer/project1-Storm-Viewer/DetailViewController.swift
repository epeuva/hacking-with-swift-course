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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // If there is any selectedImage, load the UIImage with the name of the image file
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
    }

}
