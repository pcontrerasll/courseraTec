//
//  CheeseViewController.swift
//  PizzaCreator
//
//  Created by Pilar on 03/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class CheeseViewController: OrderViewController {

    @IBOutlet weak var mozzarellaButton: UIButton!
    @IBOutlet weak var parmesanoButton: UIButton!
    @IBOutlet weak var cheddarButton: UIButton!
    @IBOutlet weak var noCheeseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.order.showOrder()
    }
    
    override func viewWillAppear(animated: Bool) {
        switch self.order.cheese{
        case "Mozarela":
            mozzarellaButton.selected = true
            parmesanoButton.selected = false
            cheddarButton.selected = false
            noCheeseButton.selected = false
        case "Parmesano":
            mozzarellaButton.selected = false
            parmesanoButton.selected = true
            cheddarButton.selected = false
            noCheeseButton.selected = false
        case "Cheddar":
            mozzarellaButton.selected = false
            parmesanoButton.selected = false
            cheddarButton.selected = true
            noCheeseButton.selected = false
        case "Sin Queso":
            mozzarellaButton.selected = false
            parmesanoButton.selected = false
            cheddarButton.selected = false
            noCheeseButton.selected = true
        default:
            mozzarellaButton.selected = false
            parmesanoButton.selected = false
            cheddarButton.selected = false
            noCheeseButton.selected = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func setMozarella(sender: AnyObject) {
        mozzarellaButton.selected = true
        parmesanoButton.selected = false
        cheddarButton.selected = false
        noCheeseButton.selected = false
        self.order.cheese = "Mozarela"
    }
    
    @IBAction func setParmesano(sender: AnyObject) {
        parmesanoButton.selected = true
        mozzarellaButton.selected = false
        cheddarButton.selected = false
        noCheeseButton.selected = false
        self.order.cheese = "Parmesano"
    }
    
    @IBAction func setCheddar(sender: AnyObject) {
        cheddarButton.selected = true
        mozzarellaButton.selected = false
        parmesanoButton.selected = false
        noCheeseButton.selected = false
        self.order.cheese = "Cheddar"
    }
    
    @IBAction func setNoCheese(sender: AnyObject) {
        noCheeseButton.selected = true
        mozzarellaButton.selected = false
        parmesanoButton.selected = false
        cheddarButton.selected = false
        self.order.cheese = "Sin Queso"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sigVista = segue.destinationViewController as! IngredientsTableViewController
        sigVista.order = self.order
    }
}
