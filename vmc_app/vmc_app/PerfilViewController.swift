//
//  PerfilViewController.swift
//  vmc_app
//
//  Created by macbook3 on 2/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    
    var window :UIWindow = UIApplication.sharedApplication().keyWindow!
    
    @IBOutlet weak var FotoPerfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        dispatch_async(dispatch_get_main_queue(), {
            if prefs.valueForKey("PHOTO") as! String != ""{
                let foto = prefs.valueForKey("PHOTO") as! String
                var uPhoto = "\(mainInstance.urlImagePerfil)\(foto)"
                uPhoto = uPhoto.convertirEspaciosGet()
                self.FotoPerfil.kf_setImageWithURL(NSURL(string: uPhoto),
                    placeholderImage: nil,
                    optionsInfo: nil,
                    progressBlock: { (receivedSize, totalSize) -> () in
                        print("Download Progress: \(receivedSize)/\(totalSize)")
                    },
                    completionHandler: { (image, error, cacheType, imageURL) -> () in
                        print("")
                    }
                )
            }else{
                self.FotoPerfil.image = UIImage(named: "photo_perfil.png")
            }
            
            self.FotoPerfil.layer.cornerRadius = self.FotoPerfil.frame.size.width / 2
            self.FotoPerfil.layer.borderColor = UIColor( red: 190/255, green: 190/255, blue:190/255, alpha: 1.0 ).CGColor
            self.FotoPerfil.layer.borderWidth = 3.0
            self.FotoPerfil.clipsToBounds = true
            
        })
    }
    
    
    @IBAction func IrAlPanel(sender: UIBarButtonItem) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("IdSWReveal")
        //.TransitionNone
        UIView.transitionWithView(self.window, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
    
}