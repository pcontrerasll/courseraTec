//
//  RAViewController.swift
//  ProyectoFinal
//
//  Created by Pilar on 30/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RAViewController: UIViewController, ARDataSource {

    var myAnnotations: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ar(arViewController: ARViewController, viewForAnnotation: ARAnnotation)->ARAnnotationView {
        let vista = TestAnnotationView()
        vista.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        vista.frame = CGRect(x: 0,y: 0, width: 150, height: 60)
        return vista
    }
    
    func iniciaRAG(){
        
        var arAnnotatios = Array<ARAnnotation>()
        
        for annotation in myAnnotations {
            let arAnnotation = ARAnnotation()
            arAnnotation.title = annotation.title
            let coordenada = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            arAnnotation.location = coordenada
            arAnnotatios.append(arAnnotation)
        }
        
        let arViewController = ARViewController()
        arViewController.debugEnabled = true
        arViewController.dataSource = self
        arViewController.maxDistance = 0
        arViewController.maxVisibleAnnotations = 100
        arViewController.maxVerticalLevel = 5
        arViewController.trackingManager.userDistanceFilter = 25
        arViewController.trackingManager.reloadDistanceFilter = 75
        arViewController.setAnnotations(arAnnotatios)
        self.presentViewController(arViewController, animated: true, completion: nil)
    }
    
}
