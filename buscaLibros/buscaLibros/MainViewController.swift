//
//  MainViewController.swift
//  buscaLibros
//
//  Created by Pilar on 26/03/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {
    
    var libros = Array<Libro>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        let vista = self.childViewControllers[0] as! LibroTableViewController
        vista.libros = self.libros
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
