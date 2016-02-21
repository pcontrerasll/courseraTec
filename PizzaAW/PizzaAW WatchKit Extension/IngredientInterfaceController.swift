//
//  IngredientInterfaceController.swift
//  PizzaAW
//
//  Created by Pilar on 21/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import WatchKit
import Foundation


class IngredientInterfaceController: WKInterfaceController {

    let ingredients = ["Aceitunas", "Anchoas", "Camarones", "Carne Molida", "Cebolla", "Champiñones", "Chorizo", "Espinaca", "Jalapeño", "Jamón", "Pavo", "Pepperoni", "Pollo", "Piña", "Salchicha", "Tocino"]
    var order: Order = Order()
    
    @IBOutlet var ingredientTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let valor = context as! Order
        order = valor
        setupTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func setupTable() {
        ingredientTable.setNumberOfRows(ingredients.count, withRowType: "IngredientTableRowController")
        for var i = 0; i < ingredients.count; ++i {
            if let row = ingredientTable.rowControllerAtIndex(i) as? IngredientTableRowController {
                row.ingredientName.setText(ingredients[i])
                if !order.ingredients.isEmpty {
                    for ingredient in order.ingredients {
                        if ingredients[i] == ingredient {
                            row.ingredientName.setTextColor(UIColor.whiteColor())
                            row.groupIngredient.setBackgroundColor(UIColor.init(red: 64/255, green: 128/255, blue: 0, alpha: 1))
                        }
                    }
                }
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        if let row = table.rowControllerAtIndex(rowIndex) as? IngredientTableRowController {
            print(order.ingredients)
            if order.ingredients.contains(ingredients[rowIndex]) {
                
                order.ingredients.removeAtIndex(order.ingredients.indexOf(ingredients[rowIndex])!)
                row.ingredientName.setTextColor(UIColor.init(red: 64/255, green: 128/255, blue: 0, alpha: 1))
                row.groupIngredient.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
                
            } else {
                if order.ingredients.count < 5 {
                    order.ingredients.append(ingredients[rowIndex])
                    row.ingredientName.setTextColor(UIColor.whiteColor())
                    row.groupIngredient.setBackgroundColor(UIColor.init(red: 64/255, green: 128/255, blue: 0, alpha: 1))
                    
                } else {
                    let ok = WKAlertAction(title: "Aceptar", style: WKAlertActionStyle.Cancel, handler: { () -> Void in
                        if let rowAux = table.rowControllerAtIndex(self.ingredients.indexOf(self.order.ingredients.popLast()!)!)  as? IngredientTableRowController {
                            rowAux.ingredientName.setTextColor(UIColor.init(red: 64/255, green: 128/255, blue: 0, alpha: 1))
                            rowAux.groupIngredient.setBackgroundColor(UIColor.init(red: 34/255, green: 34/255, blue: 34/255, alpha: 1))
                            
                            self.order.ingredients.append(self.ingredients[rowIndex])
                            row.ingredientName.setTextColor(UIColor.whiteColor())
                            row.groupIngredient.setBackgroundColor(UIColor.init(red: 64/255, green: 128/255, blue: 0, alpha: 1))
                        }
                        
                    })
                    
                    let cancel = WKAlertAction(title: "Cancelar", style: WKAlertActionStyle.Cancel, handler: { () -> Void in
                        
                        
                    })
                    self.presentAlertControllerWithTitle("Lo sentimos", message: "No se pueden elegir más de 5 ingredientes, ¿Quiere sustituir el ingrediente \(order.ingredients.last!) por \(ingredients[rowIndex])?", preferredStyle: WKAlertControllerStyle.SideBySideButtonsAlert, actions: [ok,cancel])

                }
                
                
            }
            
        }

    }
    
    @IBAction func setIngredients() {
        pushControllerWithName("ConfirmationView", context: order)
    }
    
    
}
