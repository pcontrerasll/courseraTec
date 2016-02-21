//
//  StyleInterfaceController.swift
//  PizzaAW
//
//  Created by Pilar on 19/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import WatchKit
import Foundation


class StyleInterfaceController: WKInterfaceController {

    var order: Order = Order()
    
    @IBOutlet var slimButton: WKInterfaceButton!
    @IBOutlet var fatButton: WKInterfaceButton!
    @IBOutlet var crunchyButton: WKInterfaceButton!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let valor = context as! Order
        order = valor
        if(order.style == ""){
            
            slimButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
            let attStringSlim = NSMutableAttributedString(string: "Delgada")
            attStringSlim.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringSlim.length))
            slimButton.setAttributedTitle(attStringSlim)
            
            fatButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
            let attStringFat = NSMutableAttributedString(string: "Gruesa")
            attStringFat.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringFat.length))
            fatButton.setAttributedTitle(attStringFat)
            
            crunchyButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
            let attStringCrunchy = NSMutableAttributedString(string: "Crujiente")
            attStringCrunchy.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringCrunchy.length))
            crunchyButton.setAttributedTitle(attStringCrunchy)
        } else {
            switch order.style{
            case "Delgada":
                setSlim()
            case "Gruesa":
                setFat()
            case "Crujiente":
                setCrunchy()
            default:
                print("error")
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

    @IBAction func setSlim() {
        order.style = "Delgada"
    
        slimButton.setBackgroundColor(UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1))
        let attStringSlim = NSMutableAttributedString(string: "Delgada")
        attStringSlim.setAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, attStringSlim.length))
        slimButton.setAttributedTitle(attStringSlim)
        
        fatButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringFat = NSMutableAttributedString(string: "Gruesa")
        attStringFat.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringFat.length))
        fatButton.setAttributedTitle(attStringFat)
        
        crunchyButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringCrunchy = NSMutableAttributedString(string: "Crujiente")
        attStringCrunchy.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringCrunchy.length))
        crunchyButton.setAttributedTitle(attStringCrunchy)
    }
    
    @IBAction func setFat() {
        order.style = "Gruesa"
        
        fatButton.setBackgroundColor(UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1))
        let attStringFat = NSMutableAttributedString(string: "Gruesa")
        attStringFat.setAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, attStringFat.length))
        fatButton.setAttributedTitle(attStringFat)
        
        slimButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringSlim = NSMutableAttributedString(string: "Delgada")
        attStringSlim.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringSlim.length))
        slimButton.setAttributedTitle(attStringSlim)
        
        crunchyButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringCrunchy = NSMutableAttributedString(string: "Crujiente")
        attStringCrunchy.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringCrunchy.length))
        crunchyButton.setAttributedTitle(attStringCrunchy)
    }
    
    @IBAction func setCrunchy() {
        order.style = "Crujiente"
        
        crunchyButton.setBackgroundColor(UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1))
        let attStringCrunchy = NSMutableAttributedString(string: "Crujiente")
        attStringCrunchy.setAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, attStringCrunchy.length))
        crunchyButton.setAttributedTitle(attStringCrunchy)
        
        fatButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringFat = NSMutableAttributedString(string: "Gruesa")
        attStringFat.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringFat.length))
        fatButton.setAttributedTitle(attStringFat)
        
        slimButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringSlim = NSMutableAttributedString(string: "Delgada")
        attStringSlim.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 128/255, blue: 0, alpha: 1)], range: NSMakeRange(0, attStringSlim.length))
        slimButton.setAttributedTitle(attStringSlim)
    }
    
    
    @IBAction func aceptStyle() {
        pushControllerWithName("CheeseView", context: order)
    }
    
}
