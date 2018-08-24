//
//  ActionViewController.swift
//  Extension
//
//  Created by epeuva on 24/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // extensionContext allows us to interact with parent app.
        // inputItems will carry an array of data the parent app is sending to our extension to use
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            // Array of attachments wrapped as an NSItemProvider
            if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
                // Calls the item provider so it provides "really" the item. ASYNC!
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String)
                { [unowned self] (dict, error) in
                    // NSDictionary like Dictionary, but without specifying the data types.
                    let itemDictionary = dict as! NSDictionary
                    let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                    print(javaScriptValues)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
