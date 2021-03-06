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
    var ListEmailNombre = ["Cargando..."]
    var ListEmailDescripcion = [" "]
    var ListEmailFecha = [" "]
    var listId = [" "]
    var statusCeld:String = "Init"
    let tituloMsg:String = "Error"
    let mesnsajeMsg:String = "Fallo la peticion!"
    let btnMsg:String = "OK"
    var id = String()
    var nombreE = String()
    var subjectE = String()
    
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
            let res = response as! NSHTTPURLResponse!;
           
            if (res.statusCode >= 200 && res.statusCode < 300) {
            
            if error != nil{print(error?.localizedDescription)}
            // se realiza un try para la CONVERSION DEL OBJECTO JSON A OBJECTO NSDICTIONARY
            do{
                // se intenta convertir el objecto JSON a un objecto NSDICTIONARY
                if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.ListEmailNombre.removeAll()
                        self.ListEmailDescripcion.removeAll()
                        self.ListEmailFecha.removeAll()
                        self.listId.removeAll()
                        
                        if let json = dictionary_result["result"] as? NSArray  {
                            for item in json {
                                if let Id = item.valueForKey("id") {
                                    self.listId.append(Id as! String)
                                    
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
                    PreLoading().hideLoading()
                    self.navigationController!.popToRootViewControllerAnimated(true)
                    //self.dismissViewControllerAnimated(true, completion: nil)
                    //self.performSegueWithIdentifier("panel", sender: self)
                    
                }
            }
            }else{
             NSLog("Response code: %ld", res.statusCode);
                let appDomain = NSBundle.mainBundle().bundleIdentifier
                NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                
                //al presionar boton salir, envio al modal iniciar sesion
                dispatch_async(dispatch_get_main_queue()){
                    PreLoading().hideLoading()
                    self.navigationController!.popToRootViewControllerAnimated(true)
                    //self.dismissViewControllerAnimated(true, completion: nil)
                    //self.performSegueWithIdentifier("panel", sender: self)
                    
                }
            }//fin validar response.status
            
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
        cell.imagenEmail.hidden = false
        cell.nombreEmail.hidden = false
        cell.descripcionEmail.hidden = false
        cell.fechaEmail.hidden = false
        if statusCeld == "Init" {
            statusCeld = ""
            cell.imagenEmail.hidden = true
            cell.nombreEmail.hidden = true
            cell.descripcionEmail.hidden = true
            cell.fechaEmail.hidden = true
        }
        

        cell.nombreEmail!.text = ListEmailNombre[indexPath.row]
        cell.descripcionEmail!.text = ListEmailDescripcion[indexPath.row]
        cell.fechaEmail!.text = ListEmailFecha[indexPath.row]
        
        return cell
    }
    
    // implementacion de metodo delegado
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //segue_a_campanias
        dispatch_async(dispatch_get_main_queue()){
            self.id = self.listId[indexPath.row]
            self.nombreE = self.ListEmailNombre[indexPath.row]
            self.subjectE = self.ListEmailDescripcion[indexPath.row]
            self.performSegueWithIdentifier("segue_a_campanias", sender: self)
            
        }
        TableViewEmailList.deselectRowAtIndexPath(indexPath, animated: true)
    }
 
    
    func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let miSegue = segue.identifier!
        if  miSegue == "segue_a_campanias",
            let destination = segue.destinationViewController as? CampaignsViewController
        {
            //paso el id del email a la viariable que esta en el siguiente controller
            destination.idEmail = self.id
            destination.nombreEmail = self.nombreE
            destination.subjectEmail = self.subjectE
        }
    }
    
    
}