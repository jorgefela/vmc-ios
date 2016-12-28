//
//  RecordVideoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 20/9/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation
import Alamofire

class RecordVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    let saveFileName = "/video_test.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grabar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func grabar(){
        
     
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                let idUser:Int = prefs.integerForKey("IDUSER") as Int
                let keyServer:String = (prefs.valueForKey("KEY") as? String)!
                let url_path: String = mainInstance.urlBase + "video/upload"
                print("\(idUser) \(url_path) \(keyServer)")
                // ruta via post
                // variables a enviar:
                // { id_user }
                // { nombre_video }
                // { archivo_video }
                // { archivo_imagen }
                
                /*
                 la imagen debe ser generada a partir del video
                 */
             
                imagePicker.sourceType = .Camera
                imagePicker.mediaTypes = [kUTTypeMovie as String]
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}