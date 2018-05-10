//
//  ViewController.swift
//  Dojodo
//
//  Created by Abel Araya on 5/10/18.
//  Copyright © 2018 Abel Araya. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: UIViewController, WebViewControllerDelegate, MapViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goToPlatformButtonPressed(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        
        if segue.identifier == "GoToPlatform" {
            let controller = navigationController.topViewController as! WebViewController
            controller.delegate = self
            controller.destination = "http://learn.codingdojo.com"
            // controller.loadPage()
        } else if segue.identifier == "GoToMattermost" {
            let controller = navigationController.topViewController as! WebViewController
            controller.delegate = self
            controller.destination = "http://dojo.news"
            // controller.loadPage()
        } else if segue.identifier == "FindADojo" {
            let controller = navigationController.topViewController as! MapViewController
            controller.delegate = self
        }
    }
    
    func doneButtonPressed(by controller: WebViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonPressed(by controller: MapViewController) {
        dismiss(animated: true, completion: nil)
    }
}

