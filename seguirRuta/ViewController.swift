//
//  ViewController.swift
//  seguirRuta
//
//  Created by Pilar on 01/05/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    var startLocation: CLLocation? = nil
    var lastLocation: CLLocation? = nil
    var track: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(manager: CLLocationManager , didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status == .AuthorizedWhenInUse{
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
            map.userTrackingMode = .Follow
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locationCoordinate = CLLocationCoordinate2D()
        locationCoordinate.latitude = manager.location!.coordinate.latitude
        locationCoordinate.longitude = manager.location!.coordinate.longitude
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = "\(locationCoordinate.longitude),\(locationCoordinate.latitude)"
        if startLocation == nil {
            startLocation = locations.first!
        } else {
            let lastLocation = locations.last!
            let distance = startLocation!.distanceFromLocation(lastLocation)
            startLocation = lastLocation
            track += distance
        }
        lastLocation = locations.last
        pointAnnotation.subtitle = "\(track)"
        pointAnnotation.coordinate = locationCoordinate
        self.map.addAnnotation(pointAnnotation)
        
        
    }


    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
    
    @IBAction func setViewMap(sender: AnyObject) {
        self.map.mapType = MKMapType.Standard
    }
    
    @IBAction func setSatelliteView(sender: AnyObject) {
        self.map.mapType = MKMapType.Satellite
    }
    
    @IBAction func setHybridView(sender: AnyObject) {
        self.map.mapType = MKMapType.Hybrid
    }
    
    
}

