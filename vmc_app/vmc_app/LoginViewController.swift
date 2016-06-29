//
//  LoginViewController.swift
//  vmc_app
//
//  Created by macbook3 on 28/6/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()    
    }
    
    
    
    @IBAction func btnSignin(sender: UIButton) {
        let lUsuario:NSString = txtEmail.text!
        let lContrasenia:NSString = txtPassword.text!
        let tituloMsg:String = "Ups"
        var mesnsajeMsg:String = "Username / Password empty"
        let btnMsg:String = "OK"
        
        if ( lUsuario.isEqualToString("") || lContrasenia.isEqualToString("") ) {
            
            menssages(tituloMsg, mensaje: mesnsajeMsg, txtBtn: btnMsg)
            
        }else if(!isValidEmail(lUsuario as String)){
            
            mesnsajeMsg = "Invalid email"
            menssages(tituloMsg, mensaje: mesnsajeMsg, txtBtn: btnMsg)
            
        }else{
            
            //start proceso de logueo
            
            enum JSONError: String, ErrorType {
                case NoData = "ERROR: no data"
                case ConversionFailed = "ERROR: conversion from JSON failed"
            }
            let myUrl = NSURL(string: "http://localhost:8888/vmc-ios/webservice/slim_app/public/login")
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
                    prefs.setObject(json["key"]!, forKey: "USERNAME")
                    prefs.setObject(iduser, forKey: "IDUSER")
                    prefs.setObject(name, forKey: "NAME")
                    prefs.setObject(lname, forKey: "LNAME")
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
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
    
    func isValidEmail(testStr:String) -> Bool {
        //print("email: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
    func menssages(titulo:String, mensaje:String, txtBtn:String) -> Bool {
        
        let msge = UIAlertController(title: titulo, message: mensaje, preferredStyle: .Alert)
        presentViewController(msge, animated: true, completion: nil)
        
        //aqui agrego los botones del alerta
        msge.addAction(UIAlertAction(title: txtBtn, style: .Default, handler: { (action: UIAlertAction!) in
            print("ok")
        }))
        return true
        
    }
}