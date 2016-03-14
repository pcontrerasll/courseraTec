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
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    
    let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isbn.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func procesaRespuesta(){
        self.titulo.text = ""
        self.autor.text = ""
        self.portada.image = UIImage()
        self.view.endEditing(true)
        if isbn.text == "" {
            let alert = UIAlertController(title: "AGREGAR ISBN", message: "Debe agregar un ISBN para realizar la búsqueda de datos", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let url = NSURL(string: urls + isbn.text!)
            let datos:NSData? = NSData(contentsOfURL: url!)
            if let _ = datos {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    print(json.count)
                    if(json.count != 0){
                        let jsonDico = json as! NSDictionary
                        let dicoISBN = jsonDico["ISBN:" + isbn.text!] as! NSDictionary
                        self.titulo.text = dicoISBN["title"] as! NSString as String
                        let dicoAuthors = dicoISBN["authors"] as! NSArray
                        var autores: String = "";
                        for item in dicoAuthors {
                            print(item["name"])
                            print(item["name"]!)
                            let autor = item["name"]! as! String
                            autores += autor + ", "
                        }
                        self.autor.text = autores
                        if let _ = dicoISBN["cover"] {
                            let dicoCover = dicoISBN["cover"] as! NSDictionary
                            let urlPortadaS = dicoCover["large"]! as! NSString as String
                            let urlPortada = NSURL(string: urlPortadaS)
                            self.portada.image = UIImage(data: NSData(contentsOfURL: urlPortada!)!)
                        } else {
                            self.portada.image = UIImage()
                        }
                    } else {
                        let alert = UIAlertController(title: "SIN RESULTADOS", message: "No se ha encontrado ningún libro para el código introducido, favor de verficar", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                } catch _ {
                    print("ERROR?")
                }
            } else {
                let alert = UIAlertController(title: "SIN CONEXIÓN", message: "No se ha podido conectar al sevidor, favor de intentar más tarde", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func getInfo(sender: AnyObject) {
        procesaRespuesta()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        procesaRespuesta()
        return false
    }
    
    
}

