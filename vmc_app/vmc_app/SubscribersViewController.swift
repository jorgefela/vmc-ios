//
//  SubscribersViewController.swift
//  vmc_app
//
//  Created by macbook3 on 25/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

//devuelve los datos ingresados del nuevo contacto
@objc protocol datosGuardadosNewContactoDelagado {
    func getDatosGuardados(nroRegistros: String, filaSelcc:NSIndexPath)
}

class SubscribersViewController: UIViewController {
    
    weak var delagadoNewContacto : datosGuardadosNewContactoDelagado?
    
    
    @IBOutlet weak var EmailContacto: UITextField!
    
    
    @IBOutlet weak var NombreContacto: UITextField!
    
    
    @IBOutlet weak var LastNombre: UITextField!
    
    
    @IBOutlet weak var TelfonoContacto: UITextField!
    
    var window :UIWindow = UIApplication.sharedApplication().keyWindow!
    
    //declaracion para mesajes
    var tituloMsg:String = "oops!"
    var mesnsajeMsg:String = "email required field."
    let btnMsg:String = "OK"
    
    var filaSeleccionadaDestino:NSIndexPath?
    var id_list : String?
    
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
        let email = EmailContacto.text
        let nombre = NombreContacto.text
        let lnombre = LastNombre.text
        let telefono = TelfonoContacto.text
        if email!.isEmpty {
            mesnsajeMsg = "email required field."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus:self.EmailContacto)
        }else if(!FuncGlobal().isValidEmail(email! as String)){
            mesnsajeMsg = "invalid email."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus:self.EmailContacto)
        }else if nombre!.isEmpty {
            mesnsajeMsg = "name required field"
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus:self.NombreContacto)
        }else if lnombre!.isEmpty {
            mesnsajeMsg = "last name required field"
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus:self.LastNombre)
        }else if telefono!.isEmpty {
            mesnsajeMsg = "phone required field"
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus:self.TelfonoContacto)
        }else{
        }
    }
    
    
    @IBAction func Atras(sender: UIBarButtonItem) {
        
        if let navigationController = self.navigationController
        {
            dispatch_async(dispatch_get_main_queue()){
                if let miFila : NSIndexPath = self.filaSeleccionadaDestino {
                    self.delagadoNewContacto?.getDatosGuardados("8", filaSelcc: miFila)
                }
                
                navigationController.popViewControllerAnimated(true)
            }
        }
    }
    
    
    @IBAction func IrAlPanel(sender: UIBarButtonItem) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("IdSWReveal")
        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
    

    
    
    
    
}
