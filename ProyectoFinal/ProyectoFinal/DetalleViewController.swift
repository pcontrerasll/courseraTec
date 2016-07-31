//
//  DetalleViewController.swift
//  ProyectoFinal
//
//  Created by Pilar on 29/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {

    var evento = Evento()
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.text = evento.nombre
        fecha.text = evento.fecha
        descripcion.text = evento.descripcion
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
