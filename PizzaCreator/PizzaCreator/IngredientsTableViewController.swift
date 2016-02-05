//
//  IngredientsTableViewController.swift
//  PizzaCreator
//
//  Created by Pilar on 04/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UITableViewController {

    var order = Order()
    let limit = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        order.showOrder()
    }
    
    override func viewWillAppear(animated: Bool) {
        for section in 0..<self.tableView.numberOfSections {
            for row in 0..<self.tableView.numberOfRowsInSection(section) {
                let indexPath = NSIndexPath(forRow: row, inSection: section)
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                if self.order.ingredients.contains((cell?.textLabel?.text)!){
                    cell!.accessoryType = .Checkmark
                    self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if let sr = tableView.indexPathsForSelectedRows {
            if sr.count == limit {
                let alertController = UIAlertController(title: "Listo", message: "Tu pizza no puede tener más de 5 ingredientes", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in}))
                self.presentViewController(alertController, animated: true, completion: nil)
                return nil
            }
        }
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.selected {
                cell.accessoryType = .Checkmark
                order.ingredients.append(cell.textLabel!.text!)
                
            }
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .None
            order.ingredients.removeAtIndex(order.ingredients.indexOf(cell.textLabel!.text!)!)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sigVista = segue.destinationViewController as! OrderViewController
        sigVista.order = self.order
    }

}
