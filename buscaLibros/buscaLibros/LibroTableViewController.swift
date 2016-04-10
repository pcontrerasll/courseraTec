//
//  LibroTableViewController.swift
//  buscaLibros
//
//  Created by Pilar on 26/03/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import CoreData

class LibroTableViewController: UITableViewController {
    
    var libros = Array<Libro>()
    var contexto :NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let libroPeticion = NSEntityDescription.entityForName("Libro", inManagedObjectContext: self.contexto!)
        let peticion = libroPeticion?.managedObjectModel.fetchRequestTemplateForName("getLibros")
        do{
            let librosEntidad = try self.contexto?.executeFetchRequest(peticion!)
            for libroEntidad in librosEntidad! {
                let libro = Libro()
                libro.isbn = libroEntidad.valueForKey("isbn") as! String
                libro.titulo = libroEntidad.valueForKey("titulo") as! String
                libro.portada = libroEntidad.valueForKey("portada") as! String
                let autores = libroEntidad.valueForKey("tiene") as! Set<NSObject>
                libro.autores = autores
                var autoresStr: String = ""
                for autor in autores {
                    autoresStr += autor.valueForKey("nombre") as! String + ","
                }
                libros.append(libro)
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
        return libros.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("libro", forIndexPath: indexPath)
        cell.textLabel?.text = libros[indexPath.row].titulo
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(LibroViewController) {
            let sigVista = segue.destinationViewController as! LibroViewController
            sigVista.libros = self.libros
        } else {
            let sigVista = segue.destinationViewController as! InfoViewController
            sigVista.libro = self.libros[self.tableView.indexPathForSelectedRow!.row]
        }
    }
}
