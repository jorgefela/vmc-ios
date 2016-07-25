//
//  ViewController.swift
//  vmc_app
//
//  Created by macbook3 on 14/6/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

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
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
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
            //self.navigationController!.navigationBar.barTintColor = UIColorFromRGB(0x0A1429)
            self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
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

}