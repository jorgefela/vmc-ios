//
//  CampaignsViewController.swift
//  vmc_app
//
//  Created by macbook3 on 6/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class CampaignsViewController: UIViewController {
    var idEmail = String()
    var nombreEmail = String()
    var subjectEmail = String()
    
    @IBOutlet weak var labelNameEmail: UILabel!
    
    @IBOutlet weak var LabelSubject: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                                print(dictionary_result)
                                
                                
                                
                            })
                            
                            
                        }
                    }catch{
                        // si sucede algun problema se imprime el problema en consola
                        print("ocurrio un error")
                        print(error)
                        let appDomain = NSBundle.mainBundle().bundleIdentifier
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                        
                        dispatch_async(dispatch_get_main_queue()){
                            self.dismissViewControllerAnimated(true, completion: nil)
                            self.performSegueWithIdentifier("panel", sender: self)
                            
                        }
                    }
                }else{
                    NSLog("Response code: %ld", res.statusCode);
                    let appDomain = NSBundle.mainBundle().bundleIdentifier
                    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                    
                    dispatch_async(dispatch_get_main_queue()){
                        self.dismissViewControllerAnimated(true, completion: nil)
                        self.performSegueWithIdentifier("panel", sender: self)
                        
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

}