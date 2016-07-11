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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("aqui el id " + idEmail)
        print("nombre " + nombreEmail)
        print("subject " + subjectEmail)
        print("cargue vista Campaigns")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        if !idEmail.isEmpty {
            let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/email/\(idEmail)/campaigns"
            let url = NSURL(string: url_path)
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("\(keyServer)", forHTTPHeaderField: "key")
            let session = NSURLSession.sharedSession()
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}