//
//  Order.swift
//  PizzaAW
//
//  Created by Pilar on 17/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import Foundation


class Order{
    
    var size: String = ""
    var style: String = ""
    var cheese: String = "";
    var ingredients: [String] = []
    
    func isComplete() -> Bool{
        if size == "" {
            return false
        }
        if style == "" {
            return false
        }
        if cheese == "" {
            return false
        }
        if ingredients.isEmpty {
            return false
        }
        return true
        
    }
}