//
//  MapViewController.swift
//  Dojodo
//
//  Created by Abel Araya on 5/10/18.
//  Copyright © 2018 Abel Araya. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var destination: String?
    weak var delegate: MapViewControllerDelegate?
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.doneButtonPressed(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



