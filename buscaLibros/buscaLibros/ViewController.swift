//
//  ViewController.swift
//  buscaLibros
//
//  Created by Pilar on 06/03/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var infoBox: UITextView!
    @IBOutlet weak var procesando: UIActivityIndicatorView!
    
    
    let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isbn.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sincrono(urlMod: String) -> String{
        let url = NSURL(string: urlMod)
        let datos:NSData? = NSData(contentsOfURL: url!)
        var text: NSString = "";
        if let _ = datos {
            text = NSString(data:datos!, encoding:  NSUTF8StringEncoding)!
        } else {
            // Envia error
            text = "ERROR";
        }
        return String(text)
    }
    
    func asincrono(urlMod: String) -> String{
        let url = NSURL(string: urlMod)
        let session = NSURLSession.sharedSession()
        var texto: NSString = "";
        let bloque = { (datos: NSData?, resp: NSURLResponse?, error : NSError?) -> Void in
            texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)!
        }
        let dt = session.dataTaskWithURL(url!, completionHandler:  bloque)
        dt.resume()
        return String(texto)
    }

    func procesaRespuesta(){
        infoBox.text = "";
        procesando.startAnimating()
        self.view.endEditing(true)
        if isbn.text == "" {
            let alert = UIAlertController(title: "AGREGAR ISBN", message: "Debe agregar un ISBN para realizar la búsqueda de datos", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            var respuesta = sincrono(urls + isbn.text!)
            if respuesta == "Optional({})" || respuesta == "{}" {
                respuesta = "No se han encontrado datos"
            } else if respuesta == "ERROR" {
                respuesta = ""
                let alert = UIAlertController(title: "SIN CONEXIÓN", message: "No se ha podido conectar al sevidor, favor de intentar más tarde", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            infoBox.text = respuesta
        }
        procesando.stopAnimating()
    }
    
    @IBAction func getInfo(sender: AnyObject) {
       procesaRespuesta()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        procesaRespuesta()
        return false
    }
    
    
}

