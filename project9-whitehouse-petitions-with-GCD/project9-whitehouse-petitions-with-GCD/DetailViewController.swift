//
//  DetailViewController.swift
//  project9-whitehouse-petitions-with-GCD
//
//  Created by epeuva on 20/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks that detailItem is set or early exit
        guard detailItem != nil else { return }

        if let body = detailItem["body"], let petitionTitle = detailItem["title"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += "<h3>\(petitionTitle)</h3>"
            html += body
            html += "</body>"
            html += "</html>"
            
            title = petitionTitle
            
            // Load webView with custom HTML
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
}
