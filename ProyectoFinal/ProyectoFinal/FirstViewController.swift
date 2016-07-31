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
import CoreData

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIApplicationDelegate, WCSessionDelegate {

    private let locationManager = CLLocationManager()
    private var savingRoute = false
    private var inicio: MKMapItem!
    private var fin: MKMapItem!
    
    var myLocations: [CLLocationCoordinate2D] = []
    var myAnnotations: [MKPointAnnotation] = []
    
    var contexto :NSManagedObjectContext? = nil
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var pin: UIButton!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var actionSM: UIBarButtonItem!
    @IBOutlet weak var ra: UIButton!
    
    
    var session : WCSession!
    
    var ruta: Ruta?
    
    var rutaMostrar = Ruta()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        actionSM.enabled = false
        
        if rutaMostrar.nombre != "" {
            
            let placeMarkInicio = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: rutaMostrar.inicio!.latitud, longitude: rutaMostrar.inicio!.longitud), addressDictionary: nil)
            let pinInt = MKMapItem(placemark: placeMarkInicio)
            pinInt.name = "Inicio"
            putPin(pinInt)
            
            let placeMarkFin = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: rutaMostrar.final!.latitud, longitude: rutaMostrar.final!.longitud), addressDictionary: nil)
            let pinFin = MKMapItem(placemark: placeMarkFin)
            pinFin.name = "Final"
            putPin(pinFin)
            
            for puntoInteres in rutaMostrar.puntosInteres {
                let placeMarkPI = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: puntoInteres.coordenada!.latitud, longitude: puntoInteres.coordenada!.longitud), addressDictionary: nil)
                let pinPI = MKMapItem(placemark: placeMarkPI)
                pinPI.name = puntoInteres.nombre
                putPin(pinPI)
            }
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
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
        rutaMostrar = Ruta()
        start.enabled = false
        stop.enabled = true
        save.enabled = false
        pin.enabled = true
        camera.enabled = true
        actionSM.enabled = false
        myLocations = []
        let placeMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.map.userLocation.coordinate.latitude, longitude: self.map.userLocation.coordinate.longitude), addressDictionary: nil)
        inicio = MKMapItem(placemark: placeMark)
        inicio.name = "Inicio"
        var locationCoordinate = CLLocationCoordinate2D()
        locationCoordinate.latitude = self.map.userLocation.coordinate.latitude
        locationCoordinate.longitude = self.map.userLocation.coordinate.longitude
        myLocations.append(locationCoordinate)
        putPin(inicio)
        ruta = Ruta()
        let coordenada = Coordenada()
        coordenada.latitud = Double(locationCoordinate.latitude)
        coordenada.longitud = Double(locationCoordinate.longitude)
        ruta!.inicio = coordenada
        savingRoute = true;
        
    }
    
    
    @IBAction func stopRoute(sender: AnyObject) {
        start.enabled = true
        stop.enabled = false
        save.enabled = true
        pin.enabled = false
        camera.enabled = false
        actionSM.enabled = true
        let placeMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.map.userLocation.coordinate.latitude, longitude: self.map.userLocation.coordinate.longitude), addressDictionary: nil)
        fin = MKMapItem(placemark: placeMark)
        fin.name = "Fin"
        var locationCoordinate = CLLocationCoordinate2D()
        locationCoordinate.latitude = self.map.userLocation.coordinate.latitude
        locationCoordinate.longitude = self.map.userLocation.coordinate.longitude
        myLocations.append(locationCoordinate)
        let coordenada = Coordenada()
        coordenada.latitud = Double(locationCoordinate.latitude)
        coordenada.longitud = Double(locationCoordinate.longitude)
        ruta!.final = coordenada
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
            let coordenada = Coordenada()
            coordenada.latitud = Double(locationCoordinate.latitude)
            coordenada.longitud = Double(locationCoordinate.longitude)
            let puntoInteres = PuntoInteres()
            puntoInteres.nombre = pinInt.name!
            puntoInteres.coordenada = coordenada
            self.ruta!.puntosInteres.append(puntoInteres)
        }))
        self.presentViewController(alert, animated: true, completion: {
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(ImagePickerViewController) {
            let sigVista = segue.destinationViewController as! ImagePickerViewController
            sigVista.latitud = self.map.userLocation.coordinate.latitude
            sigVista.longitud = self.map.userLocation.coordinate.longitude
        } else if segue.destinationViewController.isKindOfClass(RAViewController) {
            let sigVista = segue.destinationViewController as! RAViewController
            sigVista.myAnnotations = self.myAnnotations
        }
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
            
        }
    }
    
    @IBAction func saveRoute(sender: UIButton) {
        
        var coordenadaInicioEntidades = Set<NSObject>()
        let coordenadaInicio = NSEntityDescription.insertNewObjectForEntityForName("Coordenada", inManagedObjectContext: self.contexto!)
        coordenadaInicio.setValue(self.ruta!.inicio!.latitud, forKey: "latitud")
        coordenadaInicio.setValue(self.ruta!.inicio!.longitud, forKey: "longitud")
        coordenadaInicioEntidades.insert(coordenadaInicio)
        
        var coordenadaFinalEntidades = Set<NSObject>()
        let coordenadaFinal = NSEntityDescription.insertNewObjectForEntityForName("Coordenada", inManagedObjectContext: self.contexto!)
        coordenadaFinal.setValue(self.ruta!.final!.latitud, forKey: "latitud")
        coordenadaFinal.setValue(self.ruta!.final!.longitud, forKey: "longitud")
        coordenadaFinalEntidades.insert(coordenadaFinal)
        
        var puntoInteresEntidades = Set<NSObject>()
        for puntoInteres in self.ruta!.puntosInteres {
            let puntoInteresEntidad = NSEntityDescription.insertNewObjectForEntityForName("PuntoInteres", inManagedObjectContext: self.contexto!)
            puntoInteresEntidad.setValue(puntoInteres.nombre, forKey: "nombre")
            if puntoInteres.imagen != nil {
                puntoInteresEntidad.setValue(UIImagePNGRepresentation(puntoInteres.imagen!), forKey: "imagen")
            }
            
            var coordenadaPuntoInteresEntidades = Set<NSObject>()
            let coordenadaPuntoInteres = NSEntityDescription.insertNewObjectForEntityForName("Coordenada", inManagedObjectContext: self.contexto!)
            coordenadaPuntoInteres.setValue(puntoInteres.coordenada!.latitud, forKey: "latitud")
            coordenadaPuntoInteres.setValue(puntoInteres.coordenada!.longitud, forKey: "longitud")
            coordenadaPuntoInteresEntidades.insert(coordenadaPuntoInteres)
            
            puntoInteresEntidad.setValue(coordenadaPuntoInteres, forKey: "tiene")
            
            puntoInteresEntidades.insert(puntoInteresEntidad)
        }
        
        let alert = UIAlertController(title: "Guardar ruta", message: "Inserte el nombre de la ruta", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            
            let rutaNueva = NSEntityDescription.insertNewObjectForEntityForName("Ruta", inManagedObjectContext: self.contexto!)
            rutaNueva.setValue(coordenadaInicio, forKey: "tieneInicio")
            rutaNueva.setValue(coordenadaFinal, forKey: "tieneFinal")
            rutaNueva.setValue(puntoInteresEntidades, forKey: "tiene")
            rutaNueva.setValue("\(self.tField.text!)", forKey: "nombre")
        
            do{
                try self.contexto?.save()
            } catch {
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
        })
       
    }
    
    
    @IBAction func compartirRuta(sender: AnyObject) {
        let actividadRD = UIActivityViewController(activityItems: myAnnotations, applicationActivities: nil)
        self.presentViewController(actividadRD, animated: true, completion: nil)
    }
    
}

