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
    var websites = ["apple.com", "hackingwithswift.com", "github.com/epeuva"]
    
    
    /// Creates the view that the controller manages. In this case, with a custom WKWebView.
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
        
        // Observe:
        // - Current controller
        // - WKWebView.estimatedProgress (#keyPath works like #selector)
        // - Pick the new value
        // - No context (the object/value that will be returned with the observer for checking purposes)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
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
        let url = URL(string: "https://" + websites[0])!
        
        // WKWebView only loads urls from URLRequest
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    /// Opens an UIAlertController in order to show the available urls to visit/open
    @objc func openTapped() {
        // actionSheet type of alert with empty message (only title)
        let ac = UIAlertController(title: "Open page...", message:nil, preferredStyle: .actionSheet)
        
        // Creates the list of websites
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        // Empty cancel button in order to close the actionSheet
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Only for iPad devices (where action sheet should be anchored)
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    
    /// Opens a webpage url, coming from an UIAlertAction.title object
    ///
    /// - Parameter action: Action generated from an UIAlertController. Its title attribute must have the url to open.
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    
    /// Adds the webpage title (from webView) to the current View
    ///
    /// - Parameters:
    ///   - webView: The web view invoking the delegate method
    ///   - navigation: The navigation object that finished. In this pp, the opened webpage.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
    /// Observes the webView estimated loading progress and sets its value to the progress view bar.
    ///
    /// - Parameters:
    ///   - keyPath: The key path, relative to object, to the value that has changed. "estimatedProgress" for this app.
    ///   - object: The source object of the key path keyPath. In this case, self.
    ///   - change: Dictionary of changes
    ///   - context: The context recieved by the observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
}

