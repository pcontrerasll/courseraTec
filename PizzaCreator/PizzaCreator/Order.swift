//
//  Orden.swift
//  PizzaCreator
//
//  Created by Pilar on 03/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import Foundation

class Order {
    
    var size: String = ""
    var style: String = ""
    var cheese: String = ""
    var ingredients: [String] = []
    
    func isCompleta()->Bool{
        if(size == ""){
            return false;
        }
        if(style == ""){
            return false
        }
        if(cheese == ""){
            return false
        }
        if(ingredients.isEmpty){
            return false
        }
        print("completa")
        return true;
    }
    
    func showOrder(){
        print("Size: " + size)
        print("Style: " + style)
        print("Cheese: " + cheese)
        print("Ingredients: " + String(ingredients.count))
    }
}