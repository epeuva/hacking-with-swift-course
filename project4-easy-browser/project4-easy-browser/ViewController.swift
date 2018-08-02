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
        
        // Create an URL object from an url
        let url = URL(string: "https://github.com/epeuva")!
        
        // WKWebView only loads urls from URLRequest
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

