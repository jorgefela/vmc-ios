//
//  SubscribersViewController.swift
//  vmc_app
//
//  Created by macbook3 on 25/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
class SubscribersViewController: UIViewController {
    
    
    @IBOutlet weak var EmailContacto: UITextField!
    
    
    @IBOutlet weak var NombreContacto: UITextField!
    
    
    @IBOutlet weak var LastNombre: UITextField!
    
    
    @IBOutlet weak var TelfonoContacto: UITextField!
    
    var window :UIWindow = UIApplication.sharedApplication().keyWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        
    }
    
    
    @IBAction func GuardaContacto(sender: UIButton) {
    }
    
    
    @IBAction func Atras(sender: UIBarButtonItem) {
        print("regrese")
        if let navigationController = self.navigationController
        {
            dispatch_async(dispatch_get_main_queue()){
                navigationController.popViewControllerAnimated(true)
            }
        }
    }
    
    
    @IBAction func IrAlPanel(sender: UIBarButtonItem) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("IdSWReveal")
        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
    
    
    
    
}
