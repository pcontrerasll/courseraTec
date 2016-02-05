//
//  DoneViewController.swift
//  PizzaCreator
//
//  Created by Pilar on 04/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class DoneViewController: OrderViewController {

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var cheeseLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.order.showOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        sizeLabel.text = "Tamaño: " + order.size
        styleLabel.text = "Masa: " + order.style
        cheeseLabel.text = "Queso: " + order.cheese
        var ingredientesText: String = "";
        for ingrediente in order.ingredients {
            ingredientesText += ingrediente + "\n"
        }
        ingredientsLabel.text = "Ingredientes:\n" + ingredientesText
        print(ingredientesText)
        
    }

    @IBAction func enviarConcina(sender: AnyObject) {
        if order.isCompleta(){
            let alertController = UIAlertController(title: "Felicidades", message: "Tu pizza está completa y será enviada a la cocina", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in}))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Tu pizza no esta completa, por favor, regresa para elegir todas las opciones", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in}))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
}
