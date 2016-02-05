//
//  SizeViewController.swift
//  PizzaCreator
//
//  Created by Pilar on 03/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class SizeViewController: OrderViewController {

    @IBOutlet weak var sizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.order.showOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func setGrande(sender: AnyObject) {
        sizeLabel.text = "Grande"
        self.order.size = "Grande"

    }
    
    @IBAction func setMediana(sender: AnyObject) {
        sizeLabel.text = "Mediana"
        self.order.size = "Mediana"
    }
    
    
    @IBAction func setChica(sender: AnyObject) {
        sizeLabel.text = "Chica"
        self.order.size = "Chica"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sigVista = segue.destinationViewController as! OrderViewController
        sigVista.order = self.order
    }
    
}
