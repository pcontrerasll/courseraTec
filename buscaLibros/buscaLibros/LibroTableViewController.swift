//
//  LibroTableViewController.swift
//  buscaLibros
//
//  Created by Pilar on 26/03/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class LibroTableViewController: UITableViewController {
    
    var libros = Array<Libro>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
