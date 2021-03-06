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
    var tableViewDes : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        
        // START -- color borde linea abajo
        /*
        let bottomBorderEmail = CALayer()
        bottomBorderEmail.frame = CGRectMake(0.0, EmailContacto.frame.size.height - 1, EmailContacto.frame.size.width, 1.0);
        bottomBorderEmail.backgroundColor = UIColor(hexaString: "#F0F0F0").CGColor
        EmailContacto.layer.addSublayer(bottomBorderEmail)
         */
        
        EmailContacto.layer.addBorder(UIRectEdge.Bottom, color: UIColor(hexaString: "#F0F0F0"), thickness: 1.5)
        /*
        let bottomBorderContacto = CALayer()
        bottomBorderContacto.frame = CGRectMake(0.0, NombreContacto.frame.size.height - 1, NombreContacto.frame.size.width, 1.0);
        bottomBorderContacto.backgroundColor = UIColor(hexaString: "#F0F0F0").CGColor
        NombreContacto.layer.addSublayer(bottomBorderContacto)
        */
        
        NombreContacto.layer.addBorder(UIRectEdge.Bottom, color: UIColor(hexaString: "#F0F0F0"), thickness: 1.5)
        /*
        let bottomBorderNombre = CALayer()
        bottomBorderNombre.frame = CGRectMake(0.0, LastNombre.frame.size.height - 0.01, LastNombre.frame.size.width, 2.0);
        bottomBorderNombre.backgroundColor = UIColor(hexaString: "#00FFCF").CGColor
        LastNombre.layer.addSublayer(bottomBorderNombre)
        */
        
        LastNombre.layer.addBorder(UIRectEdge.Bottom, color: UIColor(hexaString: "#F0F0F0"), thickness: 1.5)
        
        //let bottomBorderTlf = CALayer()
        //bottomBorderTlf.frame = CGRectMake(0.0, TelfonoContacto.frame.size.height - 1, TelfonoContacto.frame.size.width, 1.0);
        //bottomBorderTlf.backgroundColor = UIColor(hexaString: "#F0F0F0").CGColor
        //TelfonoContacto.layer.addSublayer(bottomBorderTlf)
        TelfonoContacto.layer.addBorder(UIRectEdge.Bottom, color: UIColor(hexaString: "#F0F0F0"), thickness: 1.5)
        // END -- color borde linea abajo
        
        // START -- color placeholder
        EmailContacto.attributedPlaceholder = NSAttributedString(string:"email",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        NombreContacto.attributedPlaceholder = NSAttributedString(string:"name",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        LastNombre.attributedPlaceholder = NSAttributedString(string:"last name",
                                                                  attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        TelfonoContacto.attributedPlaceholder = NSAttributedString(string:"phone",
                                                              attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        // END -- color placeholder
        
        // START -- transparencia placeholder
        EmailContacto.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000000)
        NombreContacto.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000000)
        LastNombre.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000000)
        TelfonoContacto.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0000000)
        // END -- transparencia placeholder
        
        //START -- color y fuente placeholder
        EmailContacto.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        NombreContacto.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        LastNombre.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        TelfonoContacto.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        EmailContacto.textColor = UIColor.grayColor()
        NombreContacto.textColor = UIColor.grayColor()
        LastNombre.textColor = UIColor.grayColor()
        TelfonoContacto.textColor = UIColor.grayColor()
        //END -- color y fuente placeholder
        
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
            
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            //let estaLogueado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
            //if (estaLogueado != 1) {
            let idUser:Int = prefs.integerForKey("IDUSER") as Int
            let keyServer:String = (prefs.valueForKey("KEY") as? String)!
            //}
            let postString = "id_user=\(idUser)&id_list=\(id_list!)&nombre=\(nombre!)&lnombre=\(lnombre!)&email=\(email!)&telefono=\(telefono!)"
            print(postString)
            let url_path: String = mainInstance.urlBase + "public/contact"
            let url = NSURL(string: url_path)
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            
            request.HTTPMethod = "POST"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            request.setValue("\(keyServer)", forHTTPHeaderField: "key")
            
            let session = NSURLSession.sharedSession()
            // START -- peticion
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                
                let res = response as! NSHTTPURLResponse!;
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    if error != nil{print(error?.localizedDescription)}
                    
                    do{
                        
                        if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    
                                    let json2 = dictionary_result["rows"]! as! Int
                                    
                                    if  json2 > 0 {
                                        //let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("prueba2")
                                        //segueLista
                                        
                                        self.mesnsajeMsg = dictionary_result["message"]! as! String
                                        self.tituloMsg = "Great!"
                                        var numSubcri = ""
                                        /*if let datosJson = dictionary_result["result"] as? NSArray {
                                            numSubcri = datosJson.valueForKey("n_subcriber") as! String
                                        }*/
                                        if dictionary_result["result"]![0]!.valueForKey("n_subcriber")! as! String != "" {
                                            numSubcri = dictionary_result["result"]![0]!.valueForKey("n_subcriber")! as! String
                                        }else{
                                            numSubcri = "0"
                                        }
                                        let popUp = UIAlertController(title: self.tituloMsg, message: self.mesnsajeMsg, preferredStyle: UIAlertControllerStyle.Alert)
                                        popUp.addAction(UIAlertAction(title: self.btnMsg, style: UIAlertActionStyle.Default, handler: {alertAction in
                                            if let navigationController = self.navigationController
                                            {
                                                dispatch_async(dispatch_get_main_queue()) {
                                                    if let miFila : NSIndexPath = self.filaSeleccionadaDestino {
                                                        self.delagadoNewContacto?.getDatosGuardados("\(numSubcri)", filaSelcc: miFila)
                                                    }
                                                    navigationController.popViewControllerAnimated(true)
                                                }
                                            }
                                        }))
                                        self.presentViewController(popUp, animated: true, completion: nil)
                                        
                                    }else{
                                        print("error aqui 2 ")
                                    }
                                    
                                    PreLoading().hideLoading()
                                    
                                })
                            })
                            
                            
                        }
                    }catch{
                        print("ocurrio un error")
                        print(error)
                        let appDomain = NSBundle.mainBundle().bundleIdentifier
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                        dispatch_async(dispatch_get_main_queue()){
                            PreLoading().hideLoading()
                            self.navigationController!.popToRootViewControllerAnimated(true)
                            
                        }
                    }
                }else{
                    NSLog("Response code: %ld", res.statusCode);
                    let appDomain = NSBundle.mainBundle().bundleIdentifier
                    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                    
                    dispatch_async(dispatch_get_main_queue()){
                        PreLoading().hideLoading()
                        self.navigationController!.popToRootViewControllerAnimated(true)
                        
                    }
                }//fin validar response.status
                
            })
            
            task.resume()
            // END -- peticion
            
        }//fin else
    }
    
    
    @IBAction func Atras(sender: UIBarButtonItem) {
        
        if let navigationController = self.navigationController
        {
            dispatch_async(dispatch_get_main_queue()){
                
                navigationController.popViewControllerAnimated(true)
            }
        }
    }
    
    
    @IBAction func IrAlPanel(sender: UIBarButtonItem) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("IdSWReveal")
        UIView.transitionWithView(self.window, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
    

    
    
    
    
}
