//
//  MissingInterfaceController.swift
//  PizzaAW
//
//  Created by Pilar on 21/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import WatchKit
import Foundation


class MissingInterfaceController: WKInterfaceController {

    var order = Order()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let valor = context as! Order
        order = valor
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }


    @IBAction func reviewOrder() {
        pushControllerWithName("sizeView", context: order)
    }
    
}
