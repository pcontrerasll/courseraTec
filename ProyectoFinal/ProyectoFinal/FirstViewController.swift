    //
//  FirstViewController.swift
//  ProyectoFinal
//
//  Created by Pilar on 11/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import WatchConnectivity

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIApplicationDelegate, WCSessionDelegate {

    private let locationManager = CLLocationManager()
    private var savingRoute = false
    private var inicio: MKMapItem!
    private var fin: MKMapItem!
    
    var myLocations: [CLLocationCoordinate2D] = []
    var myAnnotations: [MKPointAnnotation] = []
    
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var pin: UIButton!
    @IBOutlet weak var camera: UIButton!
    
    var session : WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if(savingRoute) {
            if myLocations.count > 1 {
                var locationCoordinate = CLLocationCoordinate2D()
                locationCoordinate.latitude = manager.location!.coordinate.latitude
                locationCoordinate.longitude = manager.location!.coordinate.longitude
                myLocations.append(locationCoordinate)
                let polyLine = MKPolyline(coordinates: &myLocations, count: myLocations.count)
                self.map.addOverlay(polyLine, level: MKOverlayLevel.AboveRoads)
            }
            if myLocations.count == 1 {
                var locationCoordinate = CLLocationCoordinate2D()
                locationCoordinate.latitude = manager.location!.coordinate.latitude
                locationCoordinate.longitude = manager.location!.coordinate.longitude
                myLocations.append(locationCoordinate)
            }
        }
        sendData()
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blueColor()
        polylineRenderer.lineWidth = 4
        return polylineRenderer
    }
    
    @IBAction func startRoute(sender: AnyObject) {
        map.removeAnnotations(myAnnotations);
        map.removeOverlays(map.overlays)
        start.enabled = false
        stop.enabled = true
        save.enabled = false
        pin.enabled = true
        camera.enabled = true
        myLocations = []
        let placeMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.map.userLocation.coordinate.latitude, longitude: self.map.userLocation.coordinate.longitude), addressDictionary: nil)
        inicio = MKMapItem(placemark: placeMark)
        inicio.name = "Inicio"
        var locationCoordinate = CLLocationCoordinate2D()
        locationCoordinate.latitude = self.map.userLocation.coordinate.latitude
        locationCoordinate.longitude = self.map.userLocation.coordinate.longitude
        myLocations.append(locationCoordinate)
        putPin(inicio)
        savingRoute = true;
    }
    
    
    @IBAction func stopRoute(sender: AnyObject) {
        start.enabled = true
        stop.enabled = false
        save.enabled = true
        pin.enabled = false
        camera.enabled = false
        let placeMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.map.userLocation.coordinate.latitude, longitude: self.map.userLocation.coordinate.longitude), addressDictionary: nil)
        fin = MKMapItem(placemark: placeMark)
        fin.name = "Fin"
        var locationCoordinate = CLLocationCoordinate2D()
        locationCoordinate.latitude = self.map.userLocation.coordinate.latitude
        locationCoordinate.longitude = self.map.userLocation.coordinate.longitude
        myLocations.append(locationCoordinate)
        putPin(fin)
        savingRoute = false;
    }
   
    func putPin(mapItem : MKMapItem){
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapItem.placemark.coordinate
        annotation.title = mapItem.name
        myAnnotations.append(annotation)
        map.addAnnotation(annotation)
    }
    
    
    var tField: UITextField!
    
    func configurationTextField(textField: UITextField!) {
        textField.placeholder = "Nombre"
        tField = textField
    }
    
    
    func handleCancel(alertView: UIAlertAction!){
    }
    
    @IBAction func savePin(sender: AnyObject) {
        let latitud = self.map.userLocation.coordinate.latitude
        let longitud = self.map.userLocation.coordinate.longitude
        let alert = UIAlertController(title: "Agregar punto de interés", message: "Agrega pin", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            let placeMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitud, longitude: longitud), addressDictionary: nil)
            let pinInt = MKMapItem(placemark: placeMark)
            pinInt.name = "\(self.tField.text!)"
            var locationCoordinate = CLLocationCoordinate2D()
            locationCoordinate.latitude = self.map.userLocation.coordinate.latitude
            locationCoordinate.longitude = self.map.userLocation.coordinate.longitude
            self.myLocations.append(locationCoordinate)
            self.putPin(pinInt)
        }))
        self.presentViewController(alert, animated: true, completion: {
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sigVista = segue.destinationViewController as! ImagePickerViewController
        sigVista.latitud = self.map.userLocation.coordinate.latitude
        sigVista.longitud = self.map.userLocation.coordinate.longitude
    }
    
    func sendData() {
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        var locationsDic = [String: String]()
        for annotation in myAnnotations {
            locationsDic[String(annotation.coordinate.latitude)] = String(annotation.coordinate.longitude)
        }
        do {
            try session.updateApplicationContext(locationsDic)
        } catch {
            print("error")
        }
    }
    
}

