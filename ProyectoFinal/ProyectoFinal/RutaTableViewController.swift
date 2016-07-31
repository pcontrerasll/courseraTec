//
//  RutaTableViewController.swift
//  ProyectoFinal
//
//  Created by Pilar on 29/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import CoreData

class RutaTableViewController: UITableViewController {
    
    var rutas: [Ruta] = []
    
    var contexto :NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let rutaPeticion = NSEntityDescription.entityForName("Ruta", inManagedObjectContext: self.contexto!)
        let peticion = rutaPeticion?.managedObjectModel.fetchRequestTemplateForName("getRutas")
        do{
            let rutasEntidad = try self.contexto?.executeFetchRequest(peticion!)
            for rutaEntidad in rutasEntidad! {
                let ruta = Ruta()
                ruta.nombre = rutaEntidad.valueForKey("nombre") as! String
                let coordenadaInicio = Coordenada()
                coordenadaInicio.latitud = rutaEntidad.valueForKey("tieneInicio")?.valueForKey("latitud") as! Double
                coordenadaInicio.longitud = rutaEntidad.valueForKey("tieneInicio")?.valueForKey("longitud") as! Double
                ruta.inicio = coordenadaInicio
                let coordenadaFinal = Coordenada()
                coordenadaFinal.latitud = rutaEntidad.valueForKey("tieneFinal")?.valueForKey("latitud") as! Double
                coordenadaFinal.longitud = rutaEntidad.valueForKey("tieneFinal")?.valueForKey("longitud") as! Double
                ruta.final = coordenadaFinal
                let puntosInteres = rutaEntidad.valueForKey("tiene") as! Set<NSObject>
                for puntoInteresEntity in puntosInteres {
                    let puntoInteres = PuntoInteres()
                    if let dataImg = puntoInteresEntity.valueForKey("imagen"){
                        puntoInteres.imagen = UIImage(data: dataImg as! NSData )
                    }
                    puntoInteres.nombre = puntoInteresEntity.valueForKey("nombre") as! String
                    let coordenada = Coordenada()
                    coordenada.latitud = puntoInteresEntity.valueForKey("tiene")!.valueForKey("latitud") as! Double
                    coordenada.longitud = puntoInteresEntity.valueForKey("tiene")?.valueForKey("longitud") as! Double
                    puntoInteres.coordenada = coordenada
                    ruta.puntosInteres.append(puntoInteres)
                }
                rutas.append(ruta)
            }
        } catch {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rutas.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ruta", forIndexPath: indexPath)
        cell.textLabel?.text = rutas[indexPath.row].nombre
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(FirstViewController) {
            let sigVista = segue.destinationViewController as! FirstViewController
            sigVista.rutaMostrar = self.rutas[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
