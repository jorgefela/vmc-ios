//
//  DetalleEmailViewController.swift
//  vmc_app
//
//  Created by macbook3 on 16/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
import Kingfisher

class DetalleEmailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var window : UIWindow = UIApplication.sharedApplication().keyWindow!
    
    @IBOutlet weak var tableOpciones: UITableView!
    
    var idEmail = ""
    let myCache = ImageCache(name: "vmc_cache")
    var cantReg = 0
    var indiceTable = 0
    var arrayTextOpc = ["edit email", "statistics", "delete email", "let's fly"]
    var arrayImageOpc = ["editar_email-Small", "estadistica-panel-Small", "papelera-Small", "logo_p_2-Small"]
    
    @IBOutlet weak var thumbEmailDetalle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.setAnimationsEnabled(false)
        self.navigationItem.prompt = nil
        UIView.setAnimationsEnabled(true)
        self.tableOpciones.registerClass(UITableViewCell.self, forCellReuseIdentifier: "opcionesEmail")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        
        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/email/\(idEmail)"
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
        // START -- peticion
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let res = response as! NSHTTPURLResponse!
            if (res.statusCode >= 200 && res.statusCode < 300) {
                if error != nil{print(error?.localizedDescription)}
                do{
                    if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                self.cantReg = (dictionary_result["rows"] as? Int)!
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    
                                    for item in json {
                                        
                                        if let Id = item.valueForKey("id") {
                                            
                                            let urlBase  = mainInstance.urlImagePreviewEmail + "\(Id).png"
                                            //self.thumbEmailDetalle.kf_setImageWithURL(NSURL(string: urlBase)!, placeholderImage: nil,optionsInfo: [.TargetCache(self.myCache)])
                                            //sobre escrito
                                            self.thumbEmailDetalle.image = UIImage(named: "grabacion1.png")
                                            
                                            
                                        }
                                        
                                    }//fin for
                                    
                                    
                                    
                                    //esaparecer loading
                                    // self.dismissViewControllerAnimated(false, completion: nil)
                                    
                                    
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
        
        return self.arrayTextOpc.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableOpciones.dequeueReusableCellWithIdentifier("idOpcEditEmail")! as! CustomOpcionEditEmail
        cell.textEmail.text = self.arrayTextOpc[indexPath.row]
        cell.imgEmail.image = UIImage(named: "\(self.arrayImageOpc[indexPath.row])")
        
        if indiceTable == 0 {
            print("0")
        }
        else if indiceTable == 1 {
            print("1")
            cell.backgroundColor = UIColor(hexaString: "#007AC8")
        }
        else if indiceTable == 2 {
            print("2")
            cell.backgroundColor = UIColor.redColor()
        }
        else if indiceTable == 3 {
            print("3")
            cell.backgroundColor = UIColor(hexaString: "#192C52")
        }
        //cell.iconoListaMenu.image = UIImage(named: "\(self.IconosMenu[indexPath.row])")

        
/*
        if indiceTable == 0 {
            cell.textEmail.text = "edit email"
            return cell
        }
        else if indiceTable == 1 {
            let cell = self.tableOpciones.dequeueReusableCellWithIdentifier("idOpcStatistics")! as! CustomOpcionStatistics
            return cell
        }
        else if indiceTable == 2 {
            let cell = self.tableOpciones.dequeueReusableCellWithIdentifier("idOpcEditEmail")! as! CustomOpcionEditEmail
            return cell
        }
        else if indiceTable == 3 {
            let cell = self.tableOpciones.dequeueReusableCellWithIdentifier("idOpcEditEmail")! as! CustomOpcionEditEmail
            return cell
        }*/
        
        indiceTable = indiceTable + 1
        return cell
        
    }
    

}
