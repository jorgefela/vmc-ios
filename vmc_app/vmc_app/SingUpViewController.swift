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
    
    @IBOutlet weak var BtnRegistrar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cargue vista")
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
        
        // START - Estetica input transparente
        let PrimerNombre = CALayer()
        PrimerNombre.frame = CGRectMake(0.0, FirtName.frame.size.height - 1, FirtName.frame.size.width, 1.0);
        PrimerNombre.backgroundColor = UIColor(hexaString: "#00FFCF").CGColor
        FirtName.layer.addSublayer(PrimerNombre)
        FirtName.attributedPlaceholder = NSAttributedString(string:"First Name",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        FirtName.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000001)
        
        
        let SegundoNombre = CALayer()
        SegundoNombre.frame = CGRectMake(0.0, LastName.frame.size.height - 1, LastName.frame.size.width, 1.0);
        SegundoNombre.backgroundColor = UIColor(hexaString: "#00FFCF").CGColor
        LastName.layer.addSublayer(SegundoNombre)
        LastName.attributedPlaceholder = NSAttributedString(string:"Last Name",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        LastName.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000001)
        
        
        let Emails = CALayer()
        Emails.frame = CGRectMake(0.0, emailAddres.frame.size.height - 1, emailAddres.frame.size.width, 1.0);
        Emails.backgroundColor = UIColor(hexaString: "#00FFCF").CGColor
        emailAddres.layer.addSublayer(Emails)
        emailAddres.attributedPlaceholder = NSAttributedString(string:"Email Addres",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        emailAddres.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000001)
        
        
        let Telefonos = CALayer()
        Telefonos.frame = CGRectMake(0.0, PhoneNumber.frame.size.height - 1, PhoneNumber.frame.size.width, 1.0);
        Telefonos.backgroundColor = UIColor(hexaString: "#00FFCF").CGColor
        PhoneNumber.layer.addSublayer(Telefonos)
        PhoneNumber.attributedPlaceholder = NSAttributedString(string:"Phone Number",
                                                               attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        PhoneNumber.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000001)
        
        
        // END - Estetica input transparente
        
        // START borde verde para el boton de registro
        BtnRegistrar.layer.cornerRadius = 2
        BtnRegistrar.layer.borderWidth = 1
        BtnRegistrar.layer.borderColor = UIColor(hexaString: "#00FFCF").CGColor
        // END borde verde para el bton de registro
    }
    
    @IBAction func RegistrarCuenta(sender: UIButton) {
        FuncGlobal().alert(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self)
    }
    
    
    @IBAction func IniciarSesion(sender: UIButton) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
        UIView.transitionWithView(self.window, duration: 0.1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
}
