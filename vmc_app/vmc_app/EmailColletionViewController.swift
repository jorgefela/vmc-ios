//
//  EmailColletionViewController.swift
//  vmc_app
//
//  Created by macbook3 on 13/12/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
import Kingfisher

class EmailColletionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var screenWidth = UIScreen.mainScreen().bounds.size.width
    var screenHeigh = UIScreen.mainScreen().bounds.size.height
    
    var window : UIWindow = UIApplication.sharedApplication().keyWindow!
    
    @IBOutlet weak var EmailCollectionData: UICollectionView!
    
    var IdDataCollection = [""]
    var ImgDataCollection = [""]
    var TitleDataCollection = [""]
    var cantReg = Int(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // auto adaptacion automatica
        screenWidth = (screenWidth - 12 * 4) / 2
        print("\(screenWidth) \(screenHeigh)")
        
        //parametros
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        
        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/email"
        print(url_path)
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
        print("\(keyServer)")
        
        // START -- peticion
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let res = response as! NSHTTPURLResponse!
            if (res.statusCode >= 200 && res.statusCode < 300) {
                if error != nil{print("hola" + (error?.localizedDescription)!)}
                do{
                    if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                let espacio =  "";
                                self.IdDataCollection.removeAll()
                                self.ImgDataCollection.removeAll()
                                self.TitleDataCollection.removeAll()
                                
                                
                                self.cantReg = (dictionary_result["rows"] as? Int)!
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    
                                    print(json)
                                    
                                    for item in json {
                                        
                                        if let Id = item.valueForKey("id") {
                                            
                                            self.IdDataCollection.append(Id as! String)
                                            
                                            if let title = item.valueForKey("title") {
                                                self.TitleDataCollection.append(title as! String)
                                            }else{
                                                self.TitleDataCollection.append(espacio)
                                            }
                                            
                                            if let img = item.valueForKey("title") {
                                                self.ImgDataCollection.append(img as! String)
                                            }else{
                                                self.ImgDataCollection.append(espacio)
                                            }
                                        
                                        }
                                        
                                    }//fin for
                                    
                                    
                                    //esaparecer loading
                                    // self.dismissViewControllerAnimated(false, completion: nil)
                                    self.EmailCollectionData.reloadData()
                                    
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
        
        dispatch_async(dispatch_get_main_queue()){
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
            self.navigationController!.navigationBar.translucent = false
            
            //cambia color de texto navigation controller
            let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: screenWidth, height: screenWidth)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.IdDataCollection.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomEmailColletion = EmailCollectionData.dequeueReusableCellWithReuseIdentifier("cellEmailColl", forIndexPath: indexPath) as! CustomEmailColletion
        var imagen = self.ImgDataCollection[indexPath.row] as String
        imagen = imagen.convertirEspaciosGet()
        imagen = mainInstance.urlImages + "\(imagen).gif"
        imagen = "https://www.vmctechnology.com/app/Uploads/images/NzFlODA0NTIzODZmNDk5ZDgzODZmNmUzMGY0Nzk1NDM=-f81e67657a4f43f2bb412aed62efb9d8d.gif"
        
        print(imagen)
        cell.ImgEmail.kf_setImageWithURL(NSURL(string: imagen),
                                           placeholderImage: nil,
                                           optionsInfo: nil,
                                           progressBlock: { (receivedSize, totalSize) -> () in
                                            print("Download Progress: \(receivedSize)/\(totalSize)")
            },
                                           completionHandler: { (image, error, cacheType, imageURL) -> () in
                                            print("error")
            }
        )
        //cell.ImgEmail.image =  UIImage(named:"photo_perfil.png")
        cell.TituloEmail.text = self.TitleDataCollection[indexPath.row] as String
        return cell
    }
    
    
}
