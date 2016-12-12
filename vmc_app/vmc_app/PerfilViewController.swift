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
    //obtener medidas de pantalla
    var width = UIScreen.mainScreen().bounds.size.width
    var menuRest:CGFloat = 60.0
    
    @IBOutlet weak var FotoPerfil: UIImageView!
    
    @IBOutlet weak var OpenSliderMenu: UIBarButtonItem!
    
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
            

            
        })
        
        if self.revealViewController() != nil {
            let anchoMenu = self.width - menuRest
            print(anchoMenu)
            //revealViewController().rearViewRevealWidth = anchoMenu
            OpenSliderMenu.target = self.revealViewController()
            OpenSliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }
    }
    
    
    @IBAction func IrAlPanel(sender: UIBarButtonItem) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("IdSWReveal")
        //.TransitionNone
        UIView.transitionWithView(self.window, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
    
}