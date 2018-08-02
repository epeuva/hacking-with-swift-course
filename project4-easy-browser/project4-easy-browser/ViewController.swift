//
//  ViewController.swift
//  
//
//  Created by epeuva on 02/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit
import WebKit // for WKWebView


// Check page 195 (book) for important info about Struts + Classes
// ViewController inherits from UIViewController & implements WKNavigationDelegate protocol
class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        
        // Delegation
        // Tell the webview that when something happens, inform the controller
        // You need to conform to the protocol if WKWebView
        webView.navigationDelegate = self
        
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Upper navigation "open" button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        // Progress bar
        progressView = UIProgressView(progressViewStyle: .default) // default progress bar with unfilled line
        progressView.sizeToFit() // fit the progress bar to the layout
        let progressButton = UIBarButtonItem(customView: progressView) // Creates a bar button with a custom view
        
        // Flexible empty space
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // webView.reload (aligned to the right thanks to flexible empty space)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        // Create an URL object from an url
        let url = URL(string: "https://github.com/epeuva")!
        
        // WKWebView only loads urls from URLRequest
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        // actionSheet type of alert with empty message (only title)
        let ac = UIAlertController(title: "Open page...", message:nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "apple.com",style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "github.com/epeuva", style: .default, handler: openPage))
        
        // Empty cancel button in order to close the actionSheet
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Only for iPad devices (where action sheet should be anchored)
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
}

