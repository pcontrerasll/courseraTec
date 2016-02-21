//
//  SizeInterfaceController.swift
//  PizzaAW
//
//  Created by Pilar on 18/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import WatchKit
import Foundation


class SizeInterfaceController: WKInterfaceController {

    @IBOutlet var sizeLabel: WKInterfaceLabel!
    @IBOutlet var sliderSize: WKInterfaceSlider!
    

    var order: Order = Order()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let valor = context as? Order{
            order = valor
            if(order.size == ""){
                sizeLabel.setText("Ninguno")
                sliderSize.setValue(0)
            } else {
                switch order.size {
                case "Chica":
                    sliderSize.setValue(1)
                case "Mediana":
                    sliderSize.setValue(2)
                case "Grande":
                    sliderSize.setValue(3)
                default:
                    sliderSize.setValue(0)
                }
                sizeLabel.setText(order.size)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func setSIze(value: Float) {
        switch value{
        case 1:
            order.size = "Chica"
        case 2:
            order.size = "Mediana"
        case 3:
            order.size = "Grande"
        default:
            order.size = "Ninguno"
            
        }
        sizeLabel.setText(order.size)
    }

    @IBAction func aceptSize() {
        pushControllerWithName("StyleView", context: order)
    }
}
