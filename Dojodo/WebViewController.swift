//
//  WebViewController.swift
//  Dojodo
//
//  Created by Abel Araya on 5/10/18.
//  Copyright © 2018 Abel Araya. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    weak var delegate: WebViewControllerDelegate?
    var destination: String?
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.doneButtonPressed(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.loadPage()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
//    func loadPage() {
//        if let dest = self.destination {
//            if let url = URL(string: dest) {
//                let request = URLRequest(url: url)
//                self.webView?.load(request)
//            }
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
        
        let url: URL = URL(string: "https://www.codingdojo.com/coding-schools")!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


