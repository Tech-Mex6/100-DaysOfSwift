//
//  DetailViewController.swift
//  Project16
//
//  Created by meekam okeke on 11/18/20.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate{
    var webView: WKWebView!
    var selectedCityName: String?
    let webLink = "https://en.wikipedia.org/wiki/"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

        webView.allowsBackForwardNavigationGestures = true
        
        if let selectedCity = selectedCityName{
            if let url = URL(string: webLink + "\(selectedCity)"){
                webView.load(URLRequest(url: url))
            }
        }
        
    }
}

