//
//  ViewController.swift
//  buscaLibros
//
//  Created by Pilar on 06/03/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import CoreData

class LibroViewController: UIViewController, UITextFieldDelegate {

    var libros = Array<Libro>()
    var libro = Libro()
    
    var contexto :NSManagedObjectContext? = nil

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    @IBOutlet weak var buscar: UIButton!
    @IBOutlet weak var guardar: UIBarButtonItem!
    
    
    
    let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    
    override func viewDidLoad() {
        contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        super.viewDidLoad()
        isbn.text = ""
        guardar.enabled = false
        libro = Libro()
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
            let libroPeticion = NSEntityDescription.entityForName("Libro", inManagedObjectContext: self.contexto!)
            let peticion = libroPeticion?.managedObjectModel.fetchRequestFromTemplateWithName("getLibro", substitutionVariables: ["isbn" : isbn.text!])
            do {
                let libroEntidad = try self.contexto?.executeFetchRequest(peticion!)
                if libroEntidad?.count > 0 {
                    let libroResultado = libroEntidad?.first
                    self.titulo.text = libroResultado!.valueForKey("titulo") as? String
                    let urlPortada = NSURL(string: (libroResultado!.valueForKey("portada") as? String)!)
                    if urlPortada != nil {
                        self.portada.image = UIImage(data: NSData(contentsOfURL: urlPortada!)!)
                    } else {
                        self.portada.image = UIImage()
                    }
                    let autores = libroResultado!.valueForKey("tiene") as! Set<NSObject>
                    var autoresStr: String = ""
                    for autor in autores {
                        autoresStr += autor.valueForKey("nombre") as! String + ","
                    }
                    self.autor.text = autoresStr
                    return
                }
            } catch {
            
            }
            let url = NSURL(string: urls + isbn.text!)
            libro.isbn = isbn.text!
            let datos:NSData? = NSData(contentsOfURL: url!)
            if let _ = datos {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    if(json.count != 0){
                        buscar.enabled = false
                        let jsonDico = json as! NSDictionary
                        let dicoISBN = jsonDico["ISBN:" + isbn.text!] as! NSDictionary
                        self.titulo.text = dicoISBN["title"] as! NSString as String
                        libro.titulo = dicoISBN["title"] as! NSString as String
                        let dicoAuthors = dicoISBN["authors"] as! NSArray
                        var autores: String = "";
                        for item in dicoAuthors {
                            let autor = item["name"]! as! String
                            let autorEntidad = NSEntityDescription.insertNewObjectForEntityForName("Autor", inManagedObjectContext: self.contexto!)
                            autorEntidad.setValue(autor, forKey: "nombre")
                            autores += autor + ", "
                        }
                        libro.autor = autores
                        self.autor.text = autores
                        if let _ = dicoISBN["cover"] {
                            let dicoCover = dicoISBN["cover"] as! NSDictionary
                            let urlPortadaS = dicoCover["large"]! as! NSString as String
                            let urlPortada = NSURL(string: urlPortadaS)
                            self.portada.image = UIImage(data: NSData(contentsOfURL: urlPortada!)!)
                            libro.portada = urlPortadaS
                        } else {
                            self.portada.image = UIImage()
                        }
                        libro.completo = true
                        guardar.enabled = true
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sigVista = segue.destinationViewController as! MainViewController
        if libros.contains(libro) {
            print("ya existe libro")
        } else {
            if(libro.completo) {
                self.libros.append(libro)
                let libroNuevo = NSEntityDescription.insertNewObjectForEntityForName("Libro", inManagedObjectContext: self.contexto!)
                libroNuevo.setValue(libro.isbn, forKey: "isbn")
                libroNuevo.setValue(libro.titulo, forKey: "titulo")
                libroNuevo.setValue(libro.portada, forKey: "portada")
                libroNuevo.setValue(libro.autores, forKey: "tiene")
                do{
                    try self.contexto?.save()
                } catch {
                    
                }
            }
            
        }
        sigVista.libros = self.libros
    }
    
}

