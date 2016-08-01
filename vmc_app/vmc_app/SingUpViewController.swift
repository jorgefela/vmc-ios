//
//  SingUpViewController.swift
//  vmc_app
//
//  Created by macbook3 on 28/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {
    
    var window :UIWindow = UIApplication.sharedApplication().keyWindow!
    let tituloMsg:String = "oops!"
    var mesnsajeMsg:String = "required fields"
    let btnMsg:String = "OK"
    
    @IBOutlet weak var FirtName: UITextField!
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var emailAddres: UITextField!
    
    @IBOutlet weak var PhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
    }
    
    @IBAction func RegistrarCuenta(sender: UIButton) {
        FuncGlobal().alert(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self)
    }
    
    
    @IBAction func IniciarSesion(sender: UIButton) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
        UIView.transitionWithView(self.window, duration: 0.1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
}
