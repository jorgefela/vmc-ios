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
    }
    
    
    
    @IBAction func btnSignin(sender: UIButton) {
        let lUsuario:NSString = txtEmail.text!
        let lContrasenia:NSString = txtPassword.text!
        let tituloMsg:String = "oops"
        var mesnsajeMsg:String = "Username / Password empty"
        let btnMsg:String = "OK"
        
        if ( lUsuario.isEqualToString("") || lContrasenia.isEqualToString("") ) {
            FuncGlobal().alert(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self)
            
        }else if(!FuncGlobal().isValidEmail(lUsuario as String)){
            
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
                    guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary else {
                        throw JSONError.ConversionFailed
                    }
                    let iduser = json["result"]![0]!.valueForKey("id")!
                    let lname = json["result"]![0]!.valueForKey("lname")!
                    let name = json["result"]![0]!.valueForKey("name")!
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(json["key"]!, forKey: "KEY")
                    prefs.setObject(iduser, forKey: "IDUSER")
                    prefs.setObject(name, forKey: "NAME")
                    prefs.setObject(lname, forKey: "LNAME")
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    self.dismissViewControllerAnimated(true, completion: nil)
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error as NSError {
                    print(error.debugDescription)
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