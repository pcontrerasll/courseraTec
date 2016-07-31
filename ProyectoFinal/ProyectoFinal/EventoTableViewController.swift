//
//  EventoTableViewController.swift
//  ProyectoFinal
//
//  Created by Pilar on 29/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class EventoTableViewController: UITableViewController {

    var eventos: [Evento] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text: String = "[{\"nombre\": \"La Capilla Sixtina en México\",\"descripcion\": \"Una réplica exacta en forma y contenido de la Capilla Sixtina podrá ser visitada en la Plaza de la República con la finalidad de que miles de mexicanos puedan apreciar la obra de Miguel Ángel Buonarroti, realizada hace 500 años, y que gracias a la tecnología permitirá al público de todas las edades acercarse a una  de las obras cumbre del arte de todos los tiempos.\",\"fecha\": \"8 de junio al 31 de agosto\"}, {\"nombre\": \"Orquesta Sinfónica de Minería. Programa 5\",\"descripcion\": \"Strauss Concierto para corno num. 1, Andrew Bain, corno, Bruckner, Sinfonía num. 7 \",\"fecha\": \"30 de julio al 31 de julio\"}, {\"nombre\": \"Cuatro elementos. Cantos indígenas\",\"descripcion\": \"A través de atmósferas sensoriales Cuatro Elementos Cantos indígenas invita al público a adentrarse a la vivencia y comprensión de la percepción mesoamericana de una manera contemporánea, lúdica y sorprendente.\",\"fecha\": \"8 de enero al 19 de diciembre\"}]";
        
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
                if(json.count != 0){
                    let jsonDico = json as! NSArray
                    for item in jsonDico {
                        let evento = Evento()
                        evento.nombre = item["nombre"]! as! String
                        evento.descripcion = item["descripcion"]! as! String
                        evento.fecha = item["fecha"]! as! String
                        eventos.append(evento)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("evento", forIndexPath: indexPath)
        cell.textLabel?.text = eventos[indexPath.row].nombre
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(DetalleViewController) {
            let sigVista = segue.destinationViewController as! DetalleViewController
            sigVista.evento = self.eventos[self.tableView.indexPathForSelectedRow!.row]
        }
    }
}
