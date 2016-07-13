//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Pilar on 12/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation
import MapKit
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate  {

    @IBOutlet var map: WKInterfaceMap!
    
    var session : WCSession!
    override init() {
        super.init()
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]){
        self.map.removeAllAnnotations()
        for (latitud, longitud) in applicationContext {
            let lat: Double = Double(latitud)!
            let longStr: String = longitud as! String
            let long: Double = Double(longStr)!
            let mapLocation = CLLocationCoordinate2DMake(lat, long)
            self.map.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Red)
            let location = CLLocationCoordinate2D(latitude: lat,longitude: long)
            let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.map.setRegion(region)
            
        }
    }
    
}
