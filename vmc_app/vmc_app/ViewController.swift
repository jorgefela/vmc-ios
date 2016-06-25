//
//  ViewController.swift
//  vmc_app
//
//  Created by macbook3 on 14/6/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class ViewController: UIViewController{


    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // start bloqueo autorotacion
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    // end bloqueo autorotacion

    @IBAction func btnSingIn(sender: UIButton) {
        let lUsuario:NSString = txtEmail.text!
        let lContrasenia:NSString = txtPassword.text!
        //print("\(lUsuario) \(lContrasenia)")
        if ( lUsuario.isEqualToString("") || lContrasenia.isEqualToString("") ) {
            print("datos vacios")
            //agregar mensaje
        }else if(!isValidEmail(lUsuario as String)){
            print("Email invalido")
            //agregar mensaje
        }else{
            //start proceso de logueo
            /*
            do {
                let post:NSString = "email=\(lUsuario)&password=\(lContrasenia)"
                NSLog("Datos enviados: %@",post);
                let url:NSURL = NSURL(string:"http://localhost:8888/vmc-ios/webservice/slim_app/public/login")!
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                let postLength:NSString = String( postData.length )
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.HTTPBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                var reponseError: NSError?
                var response: NSURLResponse?
                var urlData: NSData?
                
                //start verifico repuesta
                do {
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                } catch let error as NSError {
                    reponseError = error
                    urlData = nil
                }
                //end verifico repuesta
                
                //start verifico si la data esta vacia
                if ( urlData != nil ) {
                    let res = response as! NSHTTPURLResponse!;
                    NSLog("Response code: %ld", res.statusCode);
                    
                    
                    if (res.statusCode >= 200 && res.statusCode < 300){
                        
                        let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                        NSLog("Response ==> %@", responseData);
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        NSLog("Success: %ld", success);
                        if(success == 1) {
                            NSLog("Login SUCCESS");
                            
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(lUsuario, forKey: "USERNAME")
                            prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.synchronize()
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            /*
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Error desconocido"
                            }
 */
                            
                            //let alertView:UIAlertView = UIAlertView()
                            //alertView.title = "Error de inicio de sesion!"
                            //alertView.message = error_msg as String
                            //alertView.delegate = self
                            //alertView.addButtonWithTitle("OK")
                            //alertView.show()
                        }
                        
                    }else{
                        //let alertView:UIAlertView = UIAlertView()
                        //alertView.title = "Error de inicio de sesion!"
                        //alertView.message = "Fallo la conexion!"
                        //alertView.delegate = self
                        //alertView.addButtonWithTitle("OK")
                        //alertView.show()
                    }
                }else{
                    //let alertView:UIAlertView = UIAlertView()
                    //alertView.title = "Error de inicio de sesion!"
                    //alertView.message = "Error de conexión"
                    //if let error = reponseError {
                      //  alertView.message = (error.localizedDescription)
                    //}
                    //alertView.delegate = self
                    //alertView.addButtonWithTitle("OK")
                    //alertView.show()
                }
                //end verifico sila data esta vacia
                
                
                
            } catch {
                //let alertView:UIAlertView = UIAlertView()
                //alertView.title = "Error de inicio de sesion!"
                //alertView.message = "Error del Servidor"
                //alertView.delegate = self
                //alertView.addButtonWithTitle("OK")
                //alertView.show()
            }
 
 */
            
            let myUrl = NSURL(string: "http://localhost:8888/vmc-ios/webservice/slim_app/public/login")
            let request = NSMutableURLRequest(URL:myUrl!)
            request.HTTPMethod = "POST";
            
            // Compose a query string
            let postString = "email=\(lUsuario)&password=\(lContrasenia)"
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil
                {
                    print("error \(error)")
                    return
                }
                
                if let data = data,
                    jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    where error == nil {
                    
                    print("\(jsonString)")
                } else {
                    print("error=\(error!.localizedDescription)")
                }
                
                
                
            }
            
            task.resume()
            
            
            
            
            
            
            //end proceso de logueo
        }
    } //end btnSingIn
    
    func isValidEmail(testStr:String) -> Bool {
        //print("email: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }


}

