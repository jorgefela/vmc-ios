//
//  ViewController.swift
//  vmc_app
//
//  Created by macbook3 on 14/6/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
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
}

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cargue vista")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let estaRegistrado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (estaRegistrado != 1) {
            print("auto carga login")
            //cuando cargo la interfaz Inicio envio al modal iniciar sesion
            //self.performSegueWithIdentifier("segue_ir_a_login2", sender: self)
            dispatch_async(dispatch_get_main_queue()){
                
                self.performSegueWithIdentifier("segue_ir_a_login2", sender: self)
                
            }
            print("cargue login")
        } else {
            
            ////
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            //self.navigationController?.navigationBarHidden = false
            //cambia fondo navigation controller
            let bg_Nav = UIColor(hexString: "#041830")
            self.navigationController!.navigationBar.barTintColor = bg_Nav
            //tableView.rowHeight = UITableViewAutomaticDimension
            //tableView.estimatedRowHeight = 240
            
            //cambia color de texto navigation controller
            let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
            //cambia color de texto barra de estatus
            UIApplication.sharedApplication().statusBarStyle = .LightContent
            ////
            //self.labelNombreUsuario.text = prefs.valueForKey("USERNAME") as? String
            print("cargue entrada")
        }
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func CerrarTemporal(sender: UIBarButtonItem) {
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        //al presionar boton salir, envio al modal iniciar sesion
        dispatch_async(dispatch_get_main_queue()){
            self.dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("segue_ir_a_login2", sender: self)
            
        }
    }
    
    

    
    
    
   
    
    

}

