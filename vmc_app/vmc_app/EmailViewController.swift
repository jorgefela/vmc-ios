//
//  EmailViewController.swift
//  vmc_app
//
//  Created by macbook3 on 12/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
import Kingfisher

class EmailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var window : UIWindow = UIApplication.sharedApplication().keyWindow!
    
    @IBOutlet weak var emailTable: UITableView!
    
    var tituloColeccion = [""]
    var tituloColeccion2 = [""]
    var idEmailColeccion = [""]
    var idEmailColeccion2 = [""]
    
    var pase = "0"
    let myCache = ImageCache(name: "vmc_cache")
    var cantReg = 0
    
    //datos para el segue
    var idSelectEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        
        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/email"
        let url = NSURL(string: url_path)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("\(keyServer)", forHTTPHeaderField: "key")
        let urlconfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlconfig.timeoutIntervalForRequest = 300
        urlconfig.timeoutIntervalForResource = 300
        var session = NSURLSession.sharedSession()
        session = NSURLSession(configuration: urlconfig)
        /*
        // START -- alert
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .Alert)
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.presentViewController(alert, animated: true, completion: nil)
        // END -- alert
        */
        // START -- peticion
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let res = response as! NSHTTPURLResponse!
            if (res.statusCode >= 200 && res.statusCode < 300) {
                if error != nil{print(error?.localizedDescription)}
                do{
                    if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                let espacio =  "";
                                self.tituloColeccion.removeAll()
                                self.idEmailColeccion.removeAll()
                                self.tituloColeccion2.removeAll()
                                self.idEmailColeccion2.removeAll()
                                
                                self.cantReg = (dictionary_result["rows"] as? Int)!
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    self.pase = "1"
                                    var cambio = 0
                                    for item in json {
                                        
                                        if let Id = item.valueForKey("id") {
                                            
                                            //alterno entre los arrays
                                            if cambio == 0 {
                                                self.idEmailColeccion.append(Id as! String)
                                                
                                                if let title = item.valueForKey("title") {
                                                    self.tituloColeccion.append(title as! String)
                                                }else{
                                                    self.tituloColeccion.append(espacio)
                                                }
                                                cambio = 1
                                                
                                            }else{
                                                
                                                self.idEmailColeccion2.append(Id as! String)
                                                
                                                if let title = item.valueForKey("title") {
                                                    self.tituloColeccion2.append(title as! String)
                                                }else{
                                                    self.tituloColeccion2.append(espacio)
                                                }
                                                cambio = 0
                                            }
                                        
                                        }
                                        
                                    }//fin for
                                    
                                    if self.cantReg > 0 {
                                        if self.cantReg % 2 != 0 {
                                            //igualo las cantidades
                                            self.idEmailColeccion2.append("")
                                        }
                                    }
                                    
                                    
                                    //esaparecer loading
                                   // self.dismissViewControllerAnimated(false, completion: nil)
                                    self.emailTable.reloadData()
                                
                                }
                                
                            })
                        })
                    }
                }catch{
                    print("ocurrio un error")
                    print(error)
                    dispatch_async(dispatch_get_main_queue()){
                        //esaparecer loading
                        //self.dismissViewControllerAnimated(false, completion: nil)
                        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                        
                    }
                }
            }else{
                NSLog("Response code: %ld", res.statusCode)
                if res.statusCode == 401 {
                    dispatch_async(dispatch_get_main_queue()){
                        let appDomain = NSBundle.mainBundle().bundleIdentifier
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                        //esaparecer loading
                        //self.dismissViewControllerAnimated(false, completion: nil)
                        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                        
                    }
                }else{
                    dispatch_async(dispatch_get_main_queue()){
                        //esaparecer loading
                        self.dismissViewControllerAnimated(false, completion: nil)
                        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                        
                    }
                }
                
            }//fin validar response.status
            
        })
        
        task.resume()
        // END -- peticion
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.idEmailColeccion.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomEmailViewController = self.emailTable.dequeueReusableCellWithIdentifier("cell_email_mod")! as! CustomEmailViewController
        let urlBase  = mainInstance.urlImagePreviewEmail + "\(self.idEmailColeccion[indexPath.row]).png"
        var urlBase2 = ""
        if !self.idEmailColeccion2[indexPath.row].isEmpty {
            urlBase2  = mainInstance.urlImagePreviewEmail + "\(self.idEmailColeccion2[indexPath.row]).png"
            cell.titulo2email.text = self.tituloColeccion2[indexPath.row]
        }
        
        
        if pase != "0" {
            
            cell.thumb1video.kf_setImageWithURL(NSURL(string: urlBase)!, placeholderImage: nil,optionsInfo: [.TargetCache(self.myCache)])
            cell.thumb1video.tag = indexPath.row
            let tap = UITapGestureRecognizer(target: self, action: #selector(EmailViewController.emailSelect))
            cell.thumb1video.addGestureRecognizer(tap)
            cell.thumb1video.userInteractionEnabled = true
            
            if !self.idEmailColeccion2[indexPath.row].isEmpty {
                
                cell.thumb2video.kf_setImageWithURL(NSURL(string: urlBase2)!, placeholderImage: nil,optionsInfo: [.TargetCache(self.myCache)])
                cell.thumb2video.tag = indexPath.row
                let tap2 = UITapGestureRecognizer(target: self, action: #selector(EmailViewController.emailSelect2))
                cell.thumb2video.addGestureRecognizer(tap2)
                cell.thumb2video.userInteractionEnabled = true
                
            }
            
        }
        cell.titulo1email.text = self.tituloColeccion[indexPath.row]
        
        return cell
    }
    
    func emailSelect(sender:UITapGestureRecognizer)
    {
        
        
        let buttonRow = sender.view!
        idSelectEmail = idEmailColeccion[buttonRow.tag]
        print("aqui \(idSelectEmail)")
        self.performSegueWithIdentifier("segue_detalle_email", sender: self)
        //self.idList = ElementosIdList[buttonRow]
        //self.filaSeleccionada = NSIndexPath(forRow:buttonRow, inSection:0)
    }
    func emailSelect2(sender:UITapGestureRecognizer)
    {
        
        
        let buttonRow = sender.view!
        idSelectEmail = idEmailColeccion2[buttonRow.tag]
        print("aqui2 \(idSelectEmail)")
        self.performSegueWithIdentifier("segue_detalle_email", sender: self)
        //self.idList = ElementosIdList[buttonRow]
        //self.filaSeleccionada = NSIndexPath(forRow:buttonRow, inSection:0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let miSegue = segue.identifier!
        if  miSegue == "segue_detalle_email",
            let destination = segue.destinationViewController as? DetalleEmailViewController
        {
            //print(destination)
            // var indexPath : NSIndexPath?
            if let button = sender as? UIButton {
                print(button)
                
                //let cell = button.superview?.superview as! UITableViewCell
                //indexPath = self.TablaList.indexPathForCell(cell)!
                //self.idList = ElementosIdList[button.tag]
               // self.filaSeleccionada = NSIndexPath(forRow:button.tag, inSection:0)
            }
            
            //paso el id del email a la viariable que esta en el siguiente controller
            
            destination.idEmail = self.idSelectEmail
            
        }
    }
    
}
