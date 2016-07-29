//
//  CampaignsViewController.swift
//  vmc_app
//
//  Created by macbook3 on 6/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class CampaignsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var OpenSliderMenu: UIBarButtonItem!
    
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
    var ListFechaCampaigns = ["2016-02-18"]
    
    //obtener medidas de pantalla
    var width = UIScreen.mainScreen().bounds.size.width
    var menuRest:CGFloat = 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            let anchoMenu = self.width - menuRest
            revealViewController().rearViewRevealWidth = anchoMenu
            OpenSliderMenu.target = self.revealViewController()
            OpenSliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }
        
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
                                                
                                                if let fecha_envio = item.valueForKey("send_date") {
                                                    self.ListFechaCampaigns.append(fecha_envio as! String)
                                                }else{
                                                    self.ListFechaCampaigns.append(" ")
                                                }
                                            }
                                        }
                                    }//fin for
                                    self.TableViewCampaings.reloadData()
                                    PreLoading().hideLoading()
                                }
                                // end barrido datos
                            })
                            
                        }else{
                            print(res.statusCode)
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
    var filaActual:NSIndexPath?
    var filaAnterior:NSIndexPath?
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if filaActual != nil{
            filaAnterior = filaActual
        }else{
            filaAnterior = nil
        }
        
        filaActual = indexPath
        
        let previaSeleccion = filaSeleccionada
        if indexPath == filaSeleccionada {
            filaSeleccionada = nil
        }else{
            filaSeleccionada = indexPath
        }
        
        var filas: Array<NSIndexPath> = []
        var statusCelda:String = ""
        if let anterior = previaSeleccion {
            filas += [anterior]
            
            statusCelda = "hidden"
            
        }
        
        if let filaPresente = filaSeleccionada {
            filas += [filaPresente]
            statusCelda = "show"
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            tableView.reloadRowsAtIndexPaths(filas, withRowAnimation: UITableViewRowAnimation.Automatic)
        })
        
        

        let myCellShow = tableView.cellForRowAtIndexPath(filaActual!) as! CustomTableViewCellCampaigns
        
        //start consulta estadistica
        
        if statusCelda == "show"{
            let myCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCellCampaigns
            print("act \(filaActual!)")
            print("ind \(indexPath)")
            
            // START MSG LOADING
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .Alert)
            
            alert.view.tintColor = UIColor.blackColor()
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            self.presentViewController(alert, animated: true, completion: nil)
            // START MSG LOADING
            
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let idUser:Int = prefs.integerForKey("IDUSER") as Int
            let keyServer:String = (prefs.valueForKey("KEY") as? String)!
            let fecha_envio = self.ListFechaCampaigns[indexPath.row]
            let id_cat = self.ListIdCategoriaCampaigns[indexPath.row]
            let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/statictics/start_date/\(fecha_envio)/cat/\(id_cat)"
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
                                
                                // start barrido datos
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    for item in json {
                                        if let getdelivery = item.valueForKey("delivery") {
                                            myCell.dataDelivery.text = "\(getdelivery)"
                                        }else{
                                            myCell.dataDelivery.text = "0"
                                        }
                                        
                                        if let getdataOpens = item.valueForKey("opens") {
                                            myCell.dataOpens.text = "\(getdataOpens)"
                                        }else{
                                            myCell.dataOpens.text = "0"
                                        }
                                        
                                        if let getdataPlays = item.valueForKey("plays") {
                                            myCell.dataPlays.text = "\(getdataPlays)"
                                        }else{
                                            myCell.dataPlays.text = "0"
                                        }
                                        
                                        if let getdataClick = item.valueForKey("click") {
                                            myCell.dataClick.text = "\(getdataClick)"
                                        }else{
                                            myCell.dataClick.text = "0"
                                        }
                                        
                                        if let getdataBounces = item.valueForKey("bounces") {
                                            myCell.dataBounces.text = "\(getdataBounces)"
                                        }else{
                                            myCell.dataBounces.text = "0"
                                        }
                                        
                                        if let getdataSpam = item.valueForKey("spam") {
                                            myCell.dataSpam.text = "\(getdataSpam)"
                                        }else{
                                            myCell.dataSpam.text = "0"
                                        }
                                        
                                        
                                    }//fin for
                                    
                                    
                                    
                                    
                                }
                                
                                // end barrido datos
                                //esaparecer loading
                                self.dismissViewControllerAnimated(false, completion: nil)
                                tableView.reloadRowsAtIndexPaths(filas, withRowAnimation: UITableViewRowAnimation.Automatic)
                                
                                
                            })
                            
                            
                        }else{
                            print(res.statusCode)
                        }
                    }catch{
                        // si sucede algun problema se imprime el problema en consola
                        print("ocurrio un error")
                        print(error)
                        let appDomain = NSBundle.mainBundle().bundleIdentifier
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                        
                        dispatch_async(dispatch_get_main_queue()){
                            //esaparecer loading
                            self.dismissViewControllerAnimated(false, completion: nil)
                            self.navigationController!.popToRootViewControllerAnimated(true)
                            
                        }
                    }
                }else{
                    NSLog("Response code: %ld", res.statusCode);
                    let appDomain = NSBundle.mainBundle().bundleIdentifier
                    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                    
                    dispatch_async(dispatch_get_main_queue()){
                        //esaparecer loading
                        self.dismissViewControllerAnimated(false, completion: nil)
                        self.navigationController!.popToRootViewControllerAnimated(true)
                        
                    }
                }//fin validar response.status
                
            })
            
            task.resume()
            //end task
        }
        if filas.count > 0 {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if self.filaAnterior != nil {
                    let myCellHidden = tableView.cellForRowAtIndexPath(self.filaAnterior!) as! CustomTableViewCellCampaigns
                    let tamanioHidden = myCellHidden.frame.height
                    if statusCelda == "show" {
                        if self.filaAnterior == self.filaActual {
                            myCellShow.ImgenExpandir.image = UIImage(named: "menos_negro_cuadro.png")
                            
                            //self.filaAnterior  = nil
                            
                        }else{
                            
                            if myCellShow.frame.height < 200 && tamanioHidden < 200{
                                
                                myCellHidden.ImgenExpandir.image = UIImage(named: "mas_negro_cuadro.png")
                                myCellShow.ImgenExpandir.image = UIImage(named: "menos_negro_cuadro.png")
                            }else{
                                
                                myCellHidden.ImgenExpandir.image = UIImage(named: "menos_negro_cuadro.png")
                                myCellShow.ImgenExpandir.image = UIImage(named: "mas_negro_cuadro.png")
                            }
                            
                        }
                        
                    }else{
                        
                         myCellShow.ImgenExpandir.image = UIImage(named: "mas_negro_cuadro.png")
                    }
                    
                    
                }else{
                    
                    myCellShow.ImgenExpandir.image = UIImage(named: "menos_negro_cuadro.png")
                    
                }
                
                tableView.reloadRowsAtIndexPaths(filas, withRowAnimation: UITableViewRowAnimation.Automatic)
            
            })
 
            
            
            
            
        }
        
       
        //end consulta estadistica
        
        
        
        
        //TableViewCampaings.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CustomTableViewCellCampaigns).aplicarCambioFram()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CustomTableViewCellCampaigns).ignorarCambioFram()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var tamanio = CGFloat()
        if indexPath == filaSeleccionada {
            tamanio = CustomTableViewCellCampaigns.expandirAltura
        }else{
            tamanio = CustomTableViewCellCampaigns.defaultAltura
        }
        return tamanio
    }
 
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }*/
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}