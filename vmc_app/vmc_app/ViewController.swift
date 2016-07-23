//
//  ViewController.swift
//  vmc_app
//
//  Created by macbook3 on 14/6/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
/*
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}*/

class ViewController: UIViewController{
    @IBOutlet weak var OpenSliderMenu: UIBarButtonItem!
    //obtener medidas de pantalla
    var width = UIScreen.mainScreen().bounds.size.width
    var menuRest:CGFloat = 60.0
    
    
    //var height = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            let anchoMenu = self.width - menuRest
            revealViewController().rearViewRevealWidth = anchoMenu
            OpenSliderMenu.target = self.revealViewController()
            OpenSliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let estaRegistrado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (estaRegistrado != 1) {
            //cuando cargo la interfaz Inicio envio al modal iniciar sesion
            dispatch_async(dispatch_get_main_queue()){
                self.navigationController!.popToRootViewControllerAnimated(true)
                //self.performSegueWithIdentifier("segue_ir_a_login2", sender: self)
                
            }
        } else {
            
            ////
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            //cambia fondo navigation controller
            //UITabBar.appearance().barTintColor = UIColor.clearColor()
            //UITabBar.appearance().backgroundImage = UIImage()
            //UITabBar.appearance().shadowImage = UIImage()
            //let bg_Nav = UIColor(hexString: "#0A1429")
            self.navigationController!.navigationBar.barTintColor = UIColorFromRGB(0x0A1429)
            self.navigationController!.navigationBar.translucent = false
            //cambia color de texto navigation controller
            let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
            //cambia color de texto barra de estatus
            //UIApplication.sharedApplication().statusBarStyle = .LightContent
            ////
        }   
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    
    /*
    @IBAction func CerrarTemporal(sender: UIBarButtonItem) {
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        //al presionar boton salir, envio al modal iniciar sesion
        dispatch_async(dispatch_get_main_queue()){
            self.navigationController!.popToRootViewControllerAnimated(true)
            //self.dismissViewControllerAnimated(true, completion: nil)
            //self.performSegueWithIdentifier("segue_ir_a_login2", sender: self)
            
        }
    }*/
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

