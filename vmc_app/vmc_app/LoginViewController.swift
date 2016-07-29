//
//  LoginViewController.swift
//  vmc_app
//
//  Created by macbook3 on 28/6/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let estaRegistrado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (estaRegistrado == 1) {
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("panelPrincipalSegue", sender: self)
            }
        }
        
    }
    
    
    
    @IBAction func btnSignin(sender: UIButton) {
        var statusMsg:String = ""
        PreLoading().showLoading()
        
        let lUsuario:NSString = txtEmail.text!
        let lContrasenia:NSString = txtPassword.text!
        let tituloMsg:String = "oops"
        var mesnsajeMsg:String = "Username / Password empty"
        let btnMsg:String = "OK"
        
        if ( lUsuario.isEqualToString("") || lContrasenia.isEqualToString("") ) {
            PreLoading().hideLoading()
            FuncGlobal().alert(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self)
            
        }else if(!FuncGlobal().isValidEmail(lUsuario as String)){
            PreLoading().hideLoading()
            
            mesnsajeMsg = "Invalid email"
            FuncGlobal().alert(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self)
            
        }else{
            
            //start proceso de logueo
            
            enum JSONError: String, ErrorType {
                case NoData = "ERROR: no data"
                case ConversionFailed = "ERROR: conversion from JSON failed"
            }
            let myUrl = NSURL(string: mainInstance.urlBase + "public/login")
            let request = NSMutableURLRequest(URL:myUrl!)
            request.HTTPMethod = "POST";
            
            // Compose a query string
            let postString = "email=\(lUsuario)&password=\(lContrasenia)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    guard let json = try NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary else {
                        throw JSONError.ConversionFailed
                    }
                    PreLoading().hideLoading()
                    
                    let rows: Int = json["rows"]! as! Int
                    
                    if rows > 0 {
                        let iduser = json["result"]![0]!.valueForKey("id")!
                        var lname = ""
                        var name = ""
                        if json["result"]![0]!.valueForKey("lname")! as! String != "" {
                            lname = json["result"]![0]!.valueForKey("lname")! as! String
                        }else{
                            lname = ""
                        }
                        
                        if json["result"]![0]!.valueForKey("name")! as! String != "" {
                            name = json["result"]![0]!.valueForKey("name")! as! String
                        }else{
                            name = ""
                        }
                        
                        var nombre = ""
                        
                        if lname.isEmpty {
                            nombre = name
                        }else{
                            nombre = "\(name) \(lname)"
                        }
                        
                        var fotoPerfil = ""
                        if json["result"]![0]!.valueForKey("photo")!  as! String != "" {
                            fotoPerfil = json["result"]![0]!.valueForKey("photo")! as! String
                        }
                        
                        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        prefs.setObject(json["key"]!, forKey: "KEY")
                        prefs.setObject(iduser, forKey: "IDUSER")
                        prefs.setObject(nombre, forKey: "NAME")
                        prefs.setObject(fotoPerfil, forKey: "PHOTO")
                        prefs.setInteger(1, forKey: "ISLOGGEDIN")
                        prefs.synchronize()
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.performSegueWithIdentifier("panelPrincipalSegue", sender: self)
                        }
                    }else{
                        
                        statusMsg = "error_pass"
                    }
                    
                    
                } catch let error as JSONError {
                    statusMsg = "error_json"
                    print(error.rawValue)
                } catch let error as NSError {
                    statusMsg = "error_json"
                    print(error.debugDescription)
                }
                PreLoading().hideLoading()
                if statusMsg == "error_pass" {
                    mesnsajeMsg = "Username / Password invalid"
                    print(mesnsajeMsg)
                    //FuncGlobal().alert(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self)
                }
                
            }
            task.resume()
            //end proceso de logueo
        }
    }//end btnSignin
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // start bloqueo auto rotacion
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    // end bloqueo auto rotacion
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}