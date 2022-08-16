//
//  WebViewController.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var stringURL: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let url = URL(string: stringURL) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
