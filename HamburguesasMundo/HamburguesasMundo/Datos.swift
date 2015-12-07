//
//  Datos.swift
//  HamburguesasMundo
//
//  Created by Pilar on 06/12/15.
//  Copyright © 2015 MapySoft. All rights reserved.
//

import Foundation
import UIKit

class ColeccionDePaises {
    
    let paises =  ["México", "Estados Unidos", "Chile", "Argentina", "Canada", "Venezuela", "Uruguay", "Cuba", "Brasil", "Costa Rica", "España", "Australia", "Alemania", "Holanda", "Francia", "China", "Japon", "Italia", "Grecia", "Inglaterra"]
    
    func obtenPais() ->String{
        return paises[Int(arc4random()) % paises.count]
    }
    
}

class ColeccionDeHamburguesa {
    
    let hamburguesas = ["Hamburguesa Picante", "Hamburguesa BTL", "Hamburguesa Chilena", "Che Hamburguesa", "Hamburguesa con Maple", "Hamburguesa De Arepa", "Hamburguesa Gaucha", "Hamburguesa Con Platano", "Hamburguesao", "Hamburguesa Tica", "Hamburguesa con Jamon Serrano", "Hamburguesa de Canguro", "Hamburguesa a la Cerveza", "Hamburguesa Espacial", "Hamburguesa con Escargot", "Hamburguesa Beijin", "Hamburguesa Tempura", "Hamburguesa Napolitana", "Hamburguesa con Queso de Cabra", "Hamburguesa Buckingham"]
    
    func obtenHamburguesa() ->String{
        return hamburguesas[Int(arc4random()) % hamburguesas.count]
    }
    
}

struct Colores{
    
    let colores = [UIColor(red: 210/255.0, green: 90/255.0,  blue: 45/255.0, alpha: 1),
        UIColor(red: 40/255.0, green: 170/255.0,  blue: 45/255.0, alpha: 1),
        UIColor(red: 3/255.0, green: 180/255.0,  blue: 90/255.0, alpha: 1),
        UIColor(red: 210/255.0, green: 190/255.0,  blue: 5/255.0, alpha: 1),
        UIColor(red: 120/255.0, green: 120/255.0,  blue: 50/255.0, alpha: 1),
        UIColor(red: 130/255.0, green: 80/255.0,  blue: 90/255.0, alpha: 1),
        UIColor(red: 130/255.0, green: 130/255.0,  blue: 130/255.0, alpha: 1),
        UIColor(red: 3/255.0, green: 50/255.0,  blue: 90/255.0, alpha: 1)]
    
    
    
    
    
    func regresaColorAleatoreo() ->UIColor{
        return colores[Int(arc4random()) % colores.count]
    }
}