//
//  ImagePickerViewController.swift
//  ProyectoFinal
//
//  Created by Pilar on 12/07/16.
//  Copyright © 2016 MapySoft. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButon: UIButton!
    
    private let miPicker = UIImagePickerController();
    
    var latitud: CLLocationDegrees!
    var longitud: CLLocationDegrees!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            cameraButon.enabled = false
        }
        miPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func camara() {
        miPicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(miPicker, animated: true, completion: nil)
    }
 
    @IBAction func album() {
        miPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(miPicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var tField: UITextField!
    
    func configurationTextField(textField: UITextField!) {
        textField.placeholder = "Nombre"
        tField = textField
    }
    
    
    func handleCancel(alertView: UIAlertAction!){
    }
    
    @IBAction func guardar() {
        let alert = UIAlertController(title: "Agregar punto de interés", message: "Agrega pin", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            let placeMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.latitud, longitude: self.longitud), addressDictionary: nil)
            let pinInt = MKMapItem(placemark: placeMark)
            pinInt.name = "\(self.tField.text!)"
            var locationCoordinate = CLLocationCoordinate2D()
            locationCoordinate.latitude = self.latitud
            locationCoordinate.longitude = self.longitud
            
            let stack = self.navigationController!.viewControllers
            if (stack.count > 1) {
                let firstViewController = stack[stack.count-2] as! FirstViewController
                firstViewController.myLocations.append(locationCoordinate)
                firstViewController.putPin(pinInt)
            }
            
        }))
        self.presentViewController(alert, animated: true, completion: {
        })
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
}
