//
//  MapViewController.swift
//  Dojodo
//
//  Created by Abel Araya on 5/10/18.
//  Copyright © 2018 Abel Araya. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    //Map
    @IBOutlet weak var map: MKMapView!
    
    func enableBasicLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            print("Disable Location Based Features")
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            print("Enable When In Use Features")
            startMonitoringLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            // Disable location features
            print("Disable Location Based Features")
            break
            
        case .authorizedWhenInUse:
            // Enable location features
            print("Enable When In Use Features")
            startMonitoringLocation()
            break
            
        case .notDetermined, .authorizedAlways:
            break
        }
    }
    
    func startMonitoringLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1.0  // In meters.
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        print("Last location: \(lastLocation.coordinate)")
        // Do something with the location.
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    

    
    //////////////////////////////////////////////////////////
    
    
    var destination: String?
    weak var delegate: MapViewControllerDelegate?
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.doneButtonPressed(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableBasicLocationServices()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



