//
//  EmailListaStaticticsController.swift
//  vmc_app
//
//  Created by macbook3 on 1/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
class EmailListStaticticsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableViewEmailList: UITableView!
    var ListEmail = [
        "Cargando...",
        
        ]
    let tituloMsg:String = "Error"
    let mesnsajeMsg:String = "Fallo la peticion!"
    let btnMsg:String = "OK"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableViewEmailList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "viewListEmail")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //let estaLogueado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        //if (estaLogueado != 1) {
            let idUser:Int = prefs.integerForKey("IDUSER") as Int
            let keyServer:String = (prefs.valueForKey("KEY") as? String)!
            print("datos de sesion \(idUser) \(keyServer)")
            
        //}
        
        //start consulta api
        enum JSONError: String, ErrorType {
            case NoData = "ERROR: no data"
            case ConversionFailed = "ERROR: conversion from JSON failed"
        }
        let myUrl = NSURL(string: "http://localhost:8888/vmc-ios/webservice/slim_app/public/user/395/email")
        let request = NSMutableURLRequest(URL:myUrl!)
        request.HTTPMethod = "GET"
        request.setValue(keyServer, forHTTPHeaderField: "key")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                let response = json["response"]!
                if(response as! NSObject==1){
                }
                self.ListEmail.removeAll()
                let idEmail = json["result"]![0]!.valueForKey("id")!
                let titleEmail = json["result"]![0]!.valueForKey("title")!
                let subjectEmail = json["result"]![0]!.valueForKey("subject")!
                print("\(idEmail) \(titleEmail) \(subjectEmail)")
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
        
        task.resume()
        

        
        
    }
    
    //implementacion de metodo de protoloco datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListEmail.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("entre aqui \(indexPath)")
        let cell:UITableViewCell = self.TableViewEmailList.dequeueReusableCellWithIdentifier("viewListEmail")! as UITableViewCell
        
        cell.textLabel!.text = ListEmail[indexPath.row]
        
        return cell
    }
    
    // implementacion de metodo delegado
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        TableViewEmailList.deselectRowAtIndexPath(indexPath, animated: true)
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