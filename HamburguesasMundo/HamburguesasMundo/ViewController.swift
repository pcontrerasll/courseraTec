//
//  ViewController.swift
//  HamburguesasMundo
//
//  Created by Pilar on 06/12/15.
//  Copyright © 2015 MapySoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pais: UILabel!
    @IBOutlet weak var hamburguesa: UILabel!
    
    let paises = ColeccionDePaises()
    let hamburguesas = ColeccionDeHamburguesa()
    let colores = Colores()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func obtenHamburguesa() {
        view.backgroundColor = colores.regresaColorAleatoreo()
        view.tintColor = colores.regresaColorAleatoreo()
        pais.text = paises.obtenPais()
        /* Creo que la llamada a este método es incorrecta, se debería hacer una correspondencia entre los paises y las hamburguesas ya que de este modo las hamburguesas y paises no coiciden, yo haría el llamado como lo mando a imprimir a consola */
        hamburguesa.text = hamburguesas.obtenHamburguesa()
        
        let indice = Int(arc4random()) % paises.paises.count
        print("Pais: \(paises.paises[indice])")
        print("Hamburguesa: \(hamburguesas.hamburguesas[indice])")
        
    
    }
}

