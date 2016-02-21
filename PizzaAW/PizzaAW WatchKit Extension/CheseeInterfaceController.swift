//
//  CheseeInterfaceController.swift
//  PizzaAW
//
//  Created by Pilar on 20/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import WatchKit
import Foundation


class CheseeInterfaceController: WKInterfaceController {

    var order: Order = Order()
    
    @IBOutlet var mozarelaButton: WKInterfaceButton!
    @IBOutlet var cheddarButton: WKInterfaceButton!
    @IBOutlet var parmesanoButton: WKInterfaceButton!
    @IBOutlet var noChesseButton: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let valor = context as! Order
        order = valor
        if order.cheese == "" {
            mozarelaButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
            let attStringMozarela = NSMutableAttributedString(string: "Mozarela")
            attStringMozarela.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringMozarela.length))
            mozarelaButton.setAttributedTitle(attStringMozarela)
            
            cheddarButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
            let attStringCheddar = NSMutableAttributedString(string: "Cheddar")
            attStringCheddar.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringCheddar.length))
            cheddarButton.setAttributedTitle(attStringCheddar)
            
            parmesanoButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
            let attStringParmesano = NSMutableAttributedString(string: "Parme-sano")
            attStringParmesano.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringParmesano.length))
            parmesanoButton.setAttributedTitle(attStringParmesano)
            
            noChesseButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
            let attStringNoCheese = NSMutableAttributedString(string: "Sin Queso")
            attStringNoCheese.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringNoCheese.length))
             noChesseButton.setAttributedTitle(attStringNoCheese)
        } else {
            switch order.cheese{
            case "Mozarela":
                setMozarela()
            case "Cheddar":
                setCheddar()
            case "Parmesano":
                setParmesano()
            case "Sin Queso":
                setNoCheese()
            default:
                print("error")
            }
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func setMozarela() {
        order.cheese = "Mozarela"
        
        mozarelaButton.setBackgroundColor(UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1))
        let attStringMozarela = NSMutableAttributedString(string: "Mozarela")
        attStringMozarela.setAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, attStringMozarela.length))
        mozarelaButton.setAttributedTitle(attStringMozarela)
        
        cheddarButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringCheddar = NSMutableAttributedString(string: "Cheddar")
        attStringCheddar.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringCheddar.length))
        cheddarButton.setAttributedTitle(attStringCheddar)
        
        parmesanoButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringParmesano = NSMutableAttributedString(string: "Parme-sano")
        attStringParmesano.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringParmesano.length))
        parmesanoButton.setAttributedTitle(attStringParmesano)
        
        noChesseButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringNoCheese = NSMutableAttributedString(string: "Sin Queso")
        attStringNoCheese.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringNoCheese.length))
        noChesseButton.setAttributedTitle(attStringNoCheese)
        
    }
    
    @IBAction func setCheddar() {
        order.cheese = "Cheddar"
        
        cheddarButton.setBackgroundColor(UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1))
        let attStringCheddar = NSMutableAttributedString(string: "Cheddar")
        attStringCheddar.setAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, attStringCheddar.length))
        cheddarButton.setAttributedTitle(attStringCheddar)
        
        mozarelaButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringMozarela = NSMutableAttributedString(string: "Mozarela")
        attStringMozarela.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringMozarela.length))
        mozarelaButton.setAttributedTitle(attStringMozarela)
        
        parmesanoButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringParmesano = NSMutableAttributedString(string: "Parme-sano")
        attStringParmesano.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringParmesano.length))
        parmesanoButton.setAttributedTitle(attStringParmesano)
        
        noChesseButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringNoCheese = NSMutableAttributedString(string: "Sin Queso")
        attStringNoCheese.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringNoCheese.length))
        noChesseButton.setAttributedTitle(attStringNoCheese)
    }
    
    @IBAction func setParmesano() {
        order.cheese = "Parmesano"
        
        parmesanoButton.setBackgroundColor(UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1))
        let attStringParmesano = NSMutableAttributedString(string: "Parme-sano")
        attStringParmesano.setAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, attStringParmesano.length))
        parmesanoButton.setAttributedTitle(attStringParmesano)
        
        mozarelaButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringMozarela = NSMutableAttributedString(string: "Mozarela")
        attStringMozarela.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringMozarela.length))
        mozarelaButton.setAttributedTitle(attStringMozarela)
        
        cheddarButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringCheddar = NSMutableAttributedString(string: "Cheddar")
        attStringCheddar.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringCheddar.length))
        cheddarButton.setAttributedTitle(attStringCheddar)
        
        noChesseButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringNoCheese = NSMutableAttributedString(string: "Sin Queso")
        attStringNoCheese.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringNoCheese.length))
        noChesseButton.setAttributedTitle(attStringNoCheese)
    }
    
    @IBAction func setNoCheese() {
        order.cheese = "Sin Queso"
        
        noChesseButton.setBackgroundColor(UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1))
        let attStringNoCheese = NSMutableAttributedString(string: "Sin Queso")
        attStringNoCheese.setAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, attStringNoCheese.length))
        noChesseButton.setAttributedTitle(attStringNoCheese)
        
        mozarelaButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringMozarela = NSMutableAttributedString(string: "Mozarela")
        attStringMozarela.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringMozarela.length))
        mozarelaButton.setAttributedTitle(attStringMozarela)
        
        cheddarButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringCheddar = NSMutableAttributedString(string: "Cheddar")
        attStringCheddar.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringCheddar.length))
        cheddarButton.setAttributedTitle(attStringCheddar)
        
        parmesanoButton.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
        let attStringParmesano = NSMutableAttributedString(string: "Parme-sano")
        attStringParmesano.setAttributes([NSForegroundColorAttributeName: UIColor.init(red: 1, green: 204/255, blue: 102/255, alpha: 1)], range: NSMakeRange(0, attStringParmesano.length))
        parmesanoButton.setAttributedTitle(attStringParmesano)
        
    }
    
    @IBAction func setCheese() {
        pushControllerWithName("IngredientsView", context: order)
    }
    
    
}
