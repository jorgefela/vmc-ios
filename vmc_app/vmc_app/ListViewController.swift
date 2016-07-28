//
//  ListViewController.swift
//  vmc_app
//
//  Created by macbook3 on 24/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TablaList: UITableView!
    
    var width = UIScreen.mainScreen().bounds.size.width
    
    var ElementosList = [
        "Loading..."
    ]
    
    var ElementosCantList = [
        " "
    ]
    
    var ElementosIdList = [
        " "
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
        
        // START proceso de consulta
        PreLoading().showLoading()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //let estaLogueado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        //if (estaLogueado != 1) {
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        //}
        
        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/list"
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
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.ElementosList.removeAll()
                                self.ElementosCantList.removeAll()
                                self.ElementosIdList.removeAll()
                                let espacio =  " ";
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    for item in json {
                                        if let Id = item.valueForKey("id") {
                                            self.ElementosIdList.append(Id as! String)
                                            
                                            if let nombre = item.valueForKey("name") {
                                                self.ElementosList.append(nombre as! String)
                                            }else{
                                                self.ElementosList.append(espacio)
                                            }
                                            
                                            if let cantList = item.valueForKey("n_subcriber") {
                                                self.ElementosCantList.append(cantList as! String)
                                            }else{
                                                self.ElementosCantList.append("0")
                                            }
                                            
                                        }
                                    }//fin for
                                    
                                    PreLoading().hideLoading()
                                    self.TablaList.reloadData()
                                }
                                
                            })
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
        
        // END   proceso de cosulta
    }
    
    // metodos tableview controllers
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ElementosList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomListViewController = self.TablaList.dequeueReusableCellWithIdentifier("cellTablaListCustom")! as! CustomListViewController
        
        cell.nombreLista.text = self.ElementosList[indexPath.row]
        cell.cantSubcriptores.text = self.ElementosCantList[indexPath.row]
        
        let cantCaracts = self.ElementosList[indexPath.row].length
        
        if cantCaracts <= 17 {
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(16)
            //cell.nombreLista.font = UIFont(name: "Avenir", size: 16)!
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 16)!
            
        }else if cantCaracts > 17 && cantCaracts <= 19{
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(14)
            //cell.nombreLista.font = UIFont(name: "Avenir", size: 14)!
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 14)!
            
        }else if cantCaracts > 19 && cantCaracts < 23{
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(13)
            //cell.nombreLista.font = UIFont(name: "Avenir", size: 13)!
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 13)!
            
        }else{
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(12)
            //cell.nombreLista.font = UIFont(name: "Avenir", size: 12)!
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 12)!
            
        }
        
        if FuncGlobal().screenSize() == CGSizeMake(320.0, 568.0) {
            
            cell.cantSubcriptores.font = cell.cantSubcriptores.setSizeFont(11)
            cell.TextBotonLista.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 11)!
            cell.nombreLista.font = cell.nombreLista.setSizeFont(12)
            //cell.nombreLista.font = UIFont(name: "Avenir", size: 12)!
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 12)!

        } else if FuncGlobal().screenSize() == CGSizeMake(568.0, 320.0) {
            
            cell.cantSubcriptores.font = cell.cantSubcriptores.setSizeFont(13)
            cell.TextBotonLista.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 13)!
            
            if cantCaracts <= 24 {
                
                cell.nombreLista.font = cell.nombreLista.setSizeFont(13)
                //cell.nombreLista.font = UIFont(name: "Avenir", size: 13)!
                cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 13)!
                

            }else{
                cell.nombreLista.font = cell.nombreLista.setSizeFont(12)
                //cell.nombreLista.font = UIFont(name: "Avenir", size: 12)!
                cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 12)!
            }
        }
        //cell.nombreLista.frame.size.width = 100
        //cell.nombreLista.widthAnchor.constraintEqualToAnchor(nil, constant: 100).active = true
        print(FuncGlobal().screenSize())
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        TablaList.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
