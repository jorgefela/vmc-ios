//
//  ListViewController.swift
//  vmc_app
//
//  Created by macbook3 on 24/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //obtener medidas de pantalla
    var width = UIScreen.mainScreen().bounds.size.width
    var menuRest:CGFloat = 60.0
    
    var window :UIWindow = UIApplication.sharedApplication().keyWindow!
    
    @IBOutlet weak var TablaList: UITableView!
    
    @IBOutlet weak var OpenSliderMenu: UIBarButtonItem!
    
    //var width = UIScreen.mainScreen().bounds.size.width
    
    var ElementosList = [
        "Loading..."
    ]
    
    var ElementosCantList = [
        " "
    ]
    
    var ElementosIdList = [
        " "
    ]
    
    var statusCarga = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //START menu
        if self.revealViewController() != nil {
            let anchoMenu = self.width - menuRest
            revealViewController().rearViewRevealWidth = anchoMenu
            OpenSliderMenu.target = self.revealViewController()
            OpenSliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }
        //END menu

        
        
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
        
        // START proceso de consulta
        
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
        
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .Alert)
        print("\(keyServer)")
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.presentViewController(alert, animated: true, completion: nil)
 
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let res = response as! NSHTTPURLResponse!
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
                                self.statusCarga = "show"
                                
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
                                    
                                    //esaparecer loading
                                    self.dismissViewControllerAnimated(false, completion: nil)
                                    
                                    self.TablaList.reloadData()
                                }
                                
                            })
                        })
                        
                        
                    }
                }catch{
                    print("ocurrio un error")
                    print(error)
                    dispatch_async(dispatch_get_main_queue()){
                        //esaparecer loading
                        self.dismissViewControllerAnimated(false, completion: nil)
                        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                        
                    }
                }
            }else{
                NSLog("Response code: %ld", res.statusCode);
                dispatch_async(dispatch_get_main_queue()){
                    //esaparecer loading
                    self.dismissViewControllerAnimated(false, completion: nil)
                    let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                    UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                    
                }
            }//fin validar response.status
            
        })
        
        task.resume()
        // end peticion
        
        // END   proceso de cosulta
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    // metodos tableview controllers
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ElementosList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell:CustomListViewController = self.TablaList.dequeueReusableCellWithIdentifier("cellTablaListCustom")! as! CustomListViewController
        
        if self.statusCarga == "show" {
            cell.nombreLista.hidden = false
            cell.cantSubcriptores.hidden = false
            cell.TextBotonLista.hidden = false
        }else{
            cell.nombreLista.hidden = true
            cell.cantSubcriptores.hidden = true
            cell.TextBotonLista.hidden = true
        }
        
        cell.nombreLista.text = self.ElementosList[indexPath.row]
        cell.cantSubcriptores.text = self.ElementosCantList[indexPath.row]
        
        let cantCaracts = self.ElementosList[indexPath.row].length
        
        if cantCaracts <= 17 {
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(16)
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 16)!
            
        }else if cantCaracts > 17 && cantCaracts <= 19{
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(14)
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 14)!
            
        }else if cantCaracts > 19 && cantCaracts < 23{
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(13)
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 13)!
            
        }else{
            
            cell.nombreLista.font = cell.nombreLista.setSizeFont(12)
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 12)!
            
        }
        
        if FuncGlobal().screenSize() == CGSizeMake(320.0, 568.0) {
            
            cell.cantSubcriptores.font = cell.cantSubcriptores.setSizeFont(11)
            cell.TextBotonLista.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 11)!
            cell.nombreLista.font = cell.nombreLista.setSizeFont(12)
            cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 12)!

        } else if FuncGlobal().screenSize() == CGSizeMake(568.0, 320.0) {
            
            cell.cantSubcriptores.font = cell.cantSubcriptores.setSizeFont(13)
            cell.TextBotonLista.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 13)!
            
            if cantCaracts <= 24 {
                
                cell.nombreLista.font = cell.nombreLista.setSizeFont(13)
                cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 13)!
                

            }else{
                cell.nombreLista.font = cell.nombreLista.setSizeFont(12)
                cell.nombreLista.font = UIFont(name: "HelveticaNeue-Thin", size: 12)!
            }
        }
        
        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue()){
            let indexPath = tableView.indexPathForSelectedRow!
            
            let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
            
            print(currentCell.textLabel!.text)
            
            currentCell.layer.borderWidth = 2.0
            currentCell.layer.borderColor = UIColor.grayColor().CGColor
            print("entre aqui\(indexPath)")
            self.TablaList.deselectRowAtIndexPath(indexPath, animated: true)
        
        }
        
        
    }
    
    @IBAction func IrAlPanel(sender: UIBarButtonItem) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
    
    
}
