//
//  InfoViewController.swift
//  buscaLibros
//
//  Created by Pilar on 27/03/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var libro = Libro()
    
    @IBOutlet weak var isbn: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isbn.text = libro.isbn
        titulo.text = libro.titulo
        autor.text = libro.autor
        if libro.portada != "" {
            let urlPortada = NSURL(string: libro.portada)
            portada.image = UIImage(data: NSData(contentsOfURL: urlPortada!)!)
        } else {
            portada.image = UIImage()
        }
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
