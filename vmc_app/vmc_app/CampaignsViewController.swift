//
//  CampaignsViewController.swift
//  vmc_app
//
//  Created by macbook3 on 6/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class CampaignsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var filaSeleccionada:NSIndexPath?
    
    var idEmail = String()
    var nombreEmail = String()
    var subjectEmail = String()
    
    @IBOutlet weak var TableViewCampaings: UITableView!
    
    @IBOutlet weak var labelNameEmail: UILabel!
    
    @IBOutlet weak var LabelSubject: UILabel!
    
    var ListCampaigns = ["Loading..."]
    var ListIdCategoriaCampaigns = ["Loading..."]
    var ListIdCampaigns = ["Loading..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         PreLoading().showLoading()
        
        let backButton = UIBarButtonItem(title: "Back", style:.Plain, target: self, action: #selector(EmailListStaticticsController.goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        if !idEmail.isEmpty {
            
            labelNameEmail.text = nombreEmail
            LabelSubject.text = subjectEmail
            
            let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/email/\(idEmail)/campaigns"
            let url = NSURL(string: url_path)
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("\(keyServer)", forHTTPHeaderField: "key")
            
            //start task
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                
                let res = response as! NSHTTPURLResponse!;
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    if error != nil{print(error?.localizedDescription)}
                    
                    do{
                        
                        if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                self.ListCampaigns.removeAll()
                                self.ListIdCategoriaCampaigns.removeAll()
                                self.ListIdCampaigns.removeAll()
                                
                                // start barrido datos
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    for item in json {
                                        if let Id = item.valueForKey("id_camp") {
                                            self.ListIdCampaigns.append(Id as! String)
                                            
                                            if let nombre = item.valueForKey("name_campaign") {
                                                self.ListCampaigns.append(nombre as! String)
                                                
                                                if let id_categoria = item.valueForKey("category") {
                                                    self.ListIdCategoriaCampaigns.append(id_categoria as! String)
                                                }else{
                                                    self.ListIdCategoriaCampaigns.append(" ")
                                                }
                                            }
                                        }
                                    }//fin for
                                    self.TableViewCampaings.reloadData()
                                    PreLoading().hideLoading()
                                }
                                
                                // end barrido datos
                                
                                
                            })
                            
                            
                        }
                    }catch{
                        // si sucede algun problema se imprime el problema en consola
                        print("ocurrio un error")
                        print(error)
                        let appDomain = NSBundle.mainBundle().bundleIdentifier
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                        
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
                    
                    dispatch_async(dispatch_get_main_queue()){
                        PreLoading().hideLoading()
                        self.navigationController!.popToRootViewControllerAnimated(true)
                        //self.dismissViewControllerAnimated(true, completion: nil)
                        //self.performSegueWithIdentifier("panel", sender: self)
                        
                    }
                }//fin validar response.status
                
            })
            
            task.resume()
            //end task
            
        }//fin viewDidLoad
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //implementacion de metodo de protoloco datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListIdCampaigns.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomTableViewCellCampaigns = self.TableViewCampaings.dequeueReusableCellWithIdentifier("miCellCampaing2")! as! CustomTableViewCellCampaigns
        cell.LabelNombreCampaing!.text = ListCampaigns[indexPath.row]
        return cell
    }
    
    // implementacion de metodo delegado
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previaSeleccion = filaSeleccionada
        if indexPath == filaSeleccionada {
            filaSeleccionada = nil
        }else{
            filaSeleccionada = indexPath
        }
        
        var filas: Array<NSIndexPath> = []
        if let anterior = previaSeleccion {
            filas += [anterior]
        }
        if let filaPresente = filaSeleccionada {
            filas += [filaPresente]
        }
        
        if filas.count > 0 {
            tableView.reloadRowsAtIndexPaths(filas, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        //TableViewCampaings.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CustomTableViewCellCampaigns).aplicarCambioFram()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CustomTableViewCellCampaigns).ignorarCambioFram()
    }
    /*
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath == filaSeleccionada {
            print(200)
            return 200 //CustomTableViewCellCampaigns.expandirAltura
        }else{
            print(45)
            return 45//CustomTableViewCellCampaigns.defaultAltura
        }
    }*/
 
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }*/
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}