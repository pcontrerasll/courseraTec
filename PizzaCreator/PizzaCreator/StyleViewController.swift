//
//  StyleViewController.swift
//  PizzaCreator
//
//  Created by Pilar on 03/02/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class StyleViewController: OrderViewController {
    
    @IBOutlet weak var styleImage: UIImageView!
    @IBOutlet weak var styleSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.order.showOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sigVista = segue.destinationViewController as! OrderViewController
        sigVista.order = self.order
    }
    
    override func viewWillAppear(animated: Bool) {
        switch self.order.style{
        case "Delgada":
            styleSegment.selectedSegmentIndex = 0
            styleImage.image = UIImage(named: "masaDelgada")
        case "Crujiente":
            styleSegment.selectedSegmentIndex = 1
            styleImage.image = UIImage(named: "masaCrujiente")
        case "Gruesa":
            styleSegment.selectedSegmentIndex = 2
            styleImage.image = UIImage(named: "masaGruesa")
        default:
            styleImage.image = UIImage(named: "")
        }
    }
    
    @IBAction func setStyle(sender: AnyObject) {
        switch styleSegment.selectedSegmentIndex{
        case 0:
            styleImage.image = UIImage(named: "masaDelgada")
            self.order.style = "Delgada";
        case 1:
            styleImage.image = UIImage(named: "masaCrujiente")
            self.order.style = "Crujiente";
        case 2:
            styleImage.image = UIImage(named: "masaGruesa")
            self.order.style = "Gruesa";
        default:
            styleImage.image = UIImage(named: "")
        }
    }
    
    
}
