//
//  EmailListaStaticticsController.swift
//  vmc_app
//
//  Created by macbook3 on 1/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
class EmailListStaticticsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ListEmail = [
        "Cargando...",
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start consulta api
        do {
            let urlApi:NSURL = NSURL(string:"http://localhost:8888/slim_app/public/user/getAll")!
            //let getApiDatos:NSData = datosGet.dataUsingEncoding(NSASCIIStringEncoding)!
            // let getLength:NSString = String( getApiDatos.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: urlApi)
            
            request.HTTPMethod = "GET"
            /*
             request.HTTPBody = getApiDatos
             request.setValue(getLength as String, forHTTPHeaderField: "Content-Length")
             request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
             request.setValue("application/json", forHTTPHeaderField: "Accept")
             */
            
            request.HTTPBody = nil
            request.addValue("0", forHTTPHeaderField: "Content-Length")
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch let error as NSError {
                print(error)
                reponseError = error
                urlData = nil
            }
            
            //start val urlData
            if ( urlData != nil ) {
                
                let res = response as! NSHTTPURLResponse!;
                NSLog("Response code: %ld", res.statusCode);
                
                //inicializo lista empleado
                ListEmail = Array()
                
                // start val respuesta del servidor
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    NSLog("Response ==> %@", responseData);
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    let success:NSInteger = jsonData.valueForKey("response") as! NSInteger
                    NSLog("Success: %ld", success);
                    
                    
                    var error_msg:NSString
                    if(success == 1) {
                        
                        NSLog("Traje los datos");
                        //let dataArray = jsonData["result"] as! NSArray;
                        ListEmail.removeAll()
                        if let json = jsonData["result"] as? NSArray  {
                            for item in json {
                                if let name = item.valueForKey("nombre") {
                                    ListEmail.append(name as! String)
                                }
                            }
                        }
                        self.ListEmail.reloadData()
                        
                        
                        
                        
                    } else {
                        
                        
                        if jsonData["message"] as? NSString != nil {
                            error_msg = jsonData["message"] as! NSString
                        } else {
                            error_msg = "Error desconocido"
                        }
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Erroor!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        
                    }
                    
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Error!"
                    alertView.message = "Fallo la peticion!"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
                // end val respuesta del servidor
                
            } else {
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error!"
                alertView.message = "Error de conexión"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OKi")
                alertView.show()
            }
            //end val urlData
            
            
        } catch {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error!!"
            alertView.message = "Error del Servidor"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        //end consulta api
        
        
    }
    
    
    //implementacion de metodo de protoloco datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListEmail.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        print("entre aqui \(indexPath)")
        let cell:UITableViewCell = self.ListEmail.dequeueReusableCellWithIdentifier("viewListEmail")! as UITableViewCell
        
        cell.textLabel!.text = ListEmail[indexPath.row]
        
        return cell
    }
    
    // implementacion de metodo delegado
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ListEmail.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}