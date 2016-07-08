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
    var ListEmailNombre = [
        "Nombre..",
        
        ]
    
    var ListEmailDescripcion = [
        "Descripcion..",
        
        ]
    var ListEmailFecha = [
        "Fecha..",
        
        ]
    let tituloMsg:String = "Error"
    let mesnsajeMsg:String = "Fallo la peticion!"
    let btnMsg:String = "OK"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Back", style:.Plain, target: self, action: #selector(EmailListStaticticsController.goBack))
        self.navigationItem.leftBarButtonItem = backButton
        PreLoading().showLoading()
        self.TableViewEmailList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "viewListEmail")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //let estaLogueado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        //if (estaLogueado != 1) {
            let idUser:Int = prefs.integerForKey("IDUSER") as Int
            let keyServer:String = (prefs.valueForKey("KEY") as? String)!
            print("datos de sesion \(idUser) \(keyServer)")
            
        //}
        
        //start consulta api

        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/email"
        // se transforma el string url_path a tipo url
        let url = NSURL(string: url_path)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        // se le añade al objecto request el verbo http GET
        request.HTTPMethod = "GET"
        // se añadieron 2 headers a la cabecera del xml que se enviara al webservices
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // se agrego una variable en el head del xml que se enviara al webservices
        request.setValue("\(keyServer)", forHTTPHeaderField: "key")
        // se añade en la cabecera el elemento a enviar
        // se crea una session compartida para poder hacer una conexion con el servidor
        let session = NSURLSession.sharedSession()
        // la session realizara un trabajo con la request! que es objecto con los datos organizados en la cabecera
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            // se revisa si dentro del trabajo ocurrio algun problema si ocurrio algo se imprime en consola que sucedio
            if error != nil{print(error?.localizedDescription)}
            // se realiza un try para la CONVERSION DEL OBJECTO JSON A OBJECTO NSDICTIONARY
            do{
                // se intenta convertir el objecto JSON a un objecto NSDICTIONARY
                if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.ListEmailNombre.removeAll()
                        self.ListEmailDescripcion.removeAll()
                        self.ListEmailFecha.removeAll()
                        
                        if let json = dictionary_result["result"] as? NSArray  {
                            for item in json {
                                if let titulo = item.valueForKey("title") {
                                    self.ListEmailNombre.append(titulo as! String)
                                    
                                    if let descripcion = item.valueForKey("subject") {
                                        self.ListEmailDescripcion.append(descripcion as! String)
                                    }else{
                                        self.ListEmailDescripcion.append(" ")
                                    }
                                    
                                    if let fecha = item.valueForKey("created_date") {
                                        self.ListEmailFecha.append(fecha as! String)
                                    }else{
                                        self.ListEmailFecha.append(" ")
                                    }
                                }
                            }//fin for
                            self.TableViewEmailList.reloadData()
                            PreLoading().hideLoading()
                        }
                        
                    })
                    
                    
                }
            }catch{
                // si sucede algun problema se imprime el problema en consola
                print("ocurrio un error")
                print(error)
                let appDomain = NSBundle.mainBundle().bundleIdentifier
                NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                
                //al presionar boton salir, envio al modal iniciar sesion
                dispatch_async(dispatch_get_main_queue()){
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.performSegueWithIdentifier("panel", sender: self)
                    
                }
            }
            
        })
        // es la linea encargada de llamar la session de crear el trabajo y realizar lo interno dentro del trabajo
        task.resume()
    }
    
    //implementacion de metodo de protoloco datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListEmailNombre.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomTableVewCellEmail = self.TableViewEmailList.dequeueReusableCellWithIdentifier("cellEmailStatictics")! as! CustomTableVewCellEmail
        
        cell.nombreEmail!.text = ListEmailNombre[indexPath.row]
        cell.descripcionEmail!.text = ListEmailDescripcion[indexPath.row]
        cell.fechaEmail!.text = ListEmailFecha[indexPath.row]
        
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
    
    func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}