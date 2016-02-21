//
//  ConfirmationInterfaceController.swift
//  PizzaAW
//
//  Created by Pilar on 21/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import WatchKit
import Foundation


class ConfirmationInterfaceController: WKInterfaceController {

    var order = Order();
    
    @IBOutlet var sizeLabel: WKInterfaceLabel!
    @IBOutlet var styleLabel: WKInterfaceLabel!
    @IBOutlet var cheeseLabel: WKInterfaceLabel!
    @IBOutlet var ingredientesLabel: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let valor = context as! Order
        order = valor
        sizeLabel.setText(order.size)
        styleLabel.setText(order.style)
        cheeseLabel.setText(order.cheese)
        var ingredientsString = ""
        for ingredient in order.ingredients{
            ingredientsString += ingredient + ","
        }
        ingredientesLabel.setText(ingredientsString)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func confirmOrder() {
        if(order.isComplete()){
            pushControllerWithName("messageAceptView", context: order)
        } else {
            pushControllerWithName("messageMissingView", context: order)
        }
    }
    
    @IBAction func cancelOrder() {
        pushControllerWithName("sizeView", context: order)
    }
    
}
