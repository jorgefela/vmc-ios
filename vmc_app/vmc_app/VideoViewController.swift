//
//  VideoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 8/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var TableViewVideo: UITableView!
    var ListVideos = ["Cargando..."]
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //let estaLogueado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        //if (estaLogueado != 1) {
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        print("datos de sesion \(idUser) \(keyServer)")
        //}
        print("cargue controlador de video")
        
        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/email"
        let url = NSURL(string: url_path)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("\(keyServer)", forHTTPHeaderField: "key")
        let session = NSURLSession.sharedSession()
        
        // start peticion
        
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
        // end peticion
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListVideos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.TableViewVideo.dequeueReusableCellWithIdentifier("VideoCell")!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        TableViewVideo.deselectRowAtIndexPath(indexPath, animated: true)
    }
}