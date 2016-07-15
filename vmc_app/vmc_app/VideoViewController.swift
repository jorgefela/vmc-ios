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
    var ListIdVideos = ["Cargando..."]
    var ListUrlVideos = ["Cargando..."]
    var ListTipoUrlVideos = ["Cargando..."]
    var ListThumbVideos = ["Cargando..."]
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
            
            let res = response as! NSHTTPURLResponse!;
            
            if (res.statusCode >= 200 && res.statusCode < 300) {
                
                if error != nil{print(error?.localizedDescription)}
                
                do{
                    
                    if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.ListVideos.removeAll()
                            self.ListIdVideos.removeAll()
                            self.ListUrlVideos.removeAll()
                            self.ListTipoUrlVideos.removeAll()
                            self.ListThumbVideos.removeAll()
                            let espacio =  " ";
                            
                            if let json = dictionary_result["result"] as? NSArray  {
                                for item in json {
                                    if let Id = item.valueForKey("id") {
                                        self.ListIdVideos.append(Id as! String)
                                        
                                        if let nombre = item.valueForKey("name") {
                                            self.ListVideos.append(nombre as! String)
                                        }else{
                                            self.ListVideos.append(espacio)
                                        }
                                        
                                        if let urlFile = item.valueForKey("file") {
                                            self.ListUrlVideos.append(urlFile as! String)
                                        }else{
                                            self.ListUrlVideos.append(espacio)
                                        }
                                        
                                        if let tipoUrl = item.valueForKey("v_type") {
                                            self.ListTipoUrlVideos.append(tipoUrl as! String)
                                        }else{
                                            self.ListTipoUrlVideos.append(espacio)
                                        }
                                        
                                        if let thumbUrl = item.valueForKey("thumb") {
                                            self.ListThumbVideos.append(thumbUrl as! String)
                                        }else{
                                            self.ListThumbVideos.append(espacio)
                                        }
                                        
                                    }
                                }//fin for
                                self.TableViewVideo.reloadData()
                                PreLoading().hideLoading()
                            }
                            
                        })
                        
                        
                    }
                }catch{
                    print("ocurrio un error")
                    print(error)
                    let appDomain = NSBundle.mainBundle().bundleIdentifier
                    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                    dispatch_async(dispatch_get_main_queue()){
                        PreLoading().hideLoading()
                        self.navigationController!.popToRootViewControllerAnimated(true)
                        
                    }
                }
            }else{
                NSLog("Response code: %ld", res.statusCode);
                let appDomain = NSBundle.mainBundle().bundleIdentifier
                NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                
                dispatch_async(dispatch_get_main_queue()){
                    PreLoading().hideLoading()
                    self.navigationController!.popToRootViewControllerAnimated(true)
                    
                }
            }//fin validar response.status
            
        })
        
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