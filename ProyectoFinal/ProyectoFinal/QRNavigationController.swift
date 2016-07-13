//
//  QRNavigationController.swift
//  ProyectoFinal
//
//  Created by Pilar on 12/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class QRNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let origen = sender as! SecondViewController
        let destino = segue.destinationViewController as! DetalleQRViewController
        origen.sesion?.stopRunning()
        destino.urls = origen.urls
    }

}
