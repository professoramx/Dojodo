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
//import DetailViewController

class DojoLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}



class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var zoomed: Bool = false
    
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
        
        
        if !zoomed {
            zoomOnce(locations)
            zoomed = true
        }
        
        
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
        let sanJose=DojoLocation(title: "San Jose", coordinate: CLLocationCoordinate2D(latitude: 37.375681, longitude: -121.910169))
        let seattle = DojoLocation(title: "Seattle", coordinate: CLLocationCoordinate2D(latitude: 47.610054, longitude: -122.196540))
        let losAngeles = DojoLocation(title: "Los Angeles", coordinate: CLLocationCoordinate2D(latitude: 34.181074, longitude: -118.309180))
        let chicago = DojoLocation(title: "Chicago", coordinate: CLLocationCoordinate2D(latitude: 41.897440, longitude: -87.635208))
        let eastBay = DojoLocation(title: "East Bay", coordinate: CLLocationCoordinate2D(latitude: 37.842194, longitude:-122.293837))
        
        map.addAnnotation(sanJose)
        map.addAnnotation(seattle)
        map.addAnnotation(losAngeles)
        map.addAnnotation(chicago)
        map.addAnnotation(eastBay)
        map.addAnnotations([sanJose, seattle, losAngeles, chicago, eastBay])
        
        
    }
    let ann = MKPointAnnotation()
    self.ann.coordinate = annLoc
    self.ann.title = "Customize me"
    self.ann.subtitle = "???"
    self.mapView.addAnnotation(ann)
    
    
    func zoomOnce(_ locations: [CLLocation]) {
        let lastLocation = locations.last!
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(5, 5)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        self.map.showsUserLocation = true
        map.setRegion(region, animated: true)
    }
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "MyCustomAnnotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        configureDetailView(annotationView: annotationView!)
        
        return annotationView
    }
    
    func configureDetailView(annotationView: MKAnnotationView) {
        let width = 300
        let height = 200
        
        let snapshotView = UIView()
        let views = ["snapshotView": snapshotView]
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(300)]", options: [], metrics: nil, views: views))
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(200)]", options: [], metrics: nil, views: views))
        
        let options = MKMapSnapshotOptions()
        options.size = CGSize(width: width, height: height)
        options.mapType = .satelliteFlyover
        options.camera = MKMapCamera(lookingAtCenter: annotationView.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if snapshot != nil {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                imageView.image = snapshot!.image
                snapshotView.addSubview(imageView)
            }
        }
        
        annotationView.detailCalloutAccessoryView = snapshotView
    }
    
}


