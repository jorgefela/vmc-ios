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
    
    var tituloColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    var imgTituloColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    var thumbColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    var footerColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    var idEmailColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    
    var pase = "0"
    var cantReg = 0
    
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
                                self.thumbColeccion.removeAll()
                                self.idEmailColeccion.removeAll()
                                
                                self.cantReg = (dictionary_result["rows"] as? Int)!
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    self.pase = "1"
                                    for item in json {
                                        if let Id = item.valueForKey("id") {
                                            self.idEmailColeccion.append(Id as! String)
                                            
                                            if let title = item.valueForKey("title") {
                                                self.tituloColeccion.append(title as! String)
                                            }else{
                                                self.tituloColeccion.append(espacio)
                                            }
                                            
                                            
                                        }
                                    }//fin for
                                    
                                    
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
        let count = self.idEmailColeccion.count / 2
        if self.cantReg > 0 {
            if self.cantReg % 2 == 0 {
                print("\(self.cantReg) is even number")
            } else {
                print("\(self.cantReg) is odd number")
            }
        }
        
        print(count)
        return self.idEmailColeccion.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomEmailViewController = self.emailTable.dequeueReusableCellWithIdentifier("cell_email_mod")! as! CustomEmailViewController
        let urlBase  = mainInstance.urlImagePreviewEmail + "\(self.idEmailColeccion[indexPath.row]).png"
        
        if pase != "0" {
            print(urlBase)/*
            cell.thumb1video.kf_setImageWithURL(NSURL(string: urlBase)!,
                                                placeholderImage: nil,
                                                optionsInfo: nil,
                                                progressBlock: { (receivedSize, totalSize) -> () in
                                                    print("Download Progress: \(receivedSize)/\(totalSize)")
                },
                                                completionHandler: { (image, error, cacheType, imageURL) -> () in
                                                    print("Downloaded and set!")
                }
            )*/
            
            let myCache = ImageCache(name: "vmc_cache")
            
            cell.thumb1video.kf_setImageWithURL(NSURL(string: urlBase)!,
                                         placeholderImage: nil,
                                         optionsInfo: [.TargetCache(myCache)])
        }
        cell.titulo1email.text = self.tituloColeccion[indexPath.row]
        
        
        return cell
    }
    /*
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.thumbColeccion.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell_colletion", forIndexPath: indexPath) as UICollectionViewCell
        let thumbnail = cell.viewWithTag(2) as! UIImageView
        thumbnail.image = UIImage(named: "photo_perfil.png")
        let footer = cell.viewWithTag(3) as! UILabel
        print(footer)
        footer.text = self.footerColeccion[indexPath.row]
        
        return cell
    }
 */
}
