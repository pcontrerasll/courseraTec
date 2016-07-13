//
//  DetalleQRViewController.swift
//  ProyectoFinal
//
//  Created by Pilar on 12/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class DetalleQRViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var urls : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: urls!)
        let peticion = NSURLRequest(URL: url!)
        webView.loadRequest(peticion)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
