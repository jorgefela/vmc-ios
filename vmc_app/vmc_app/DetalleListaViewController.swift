//
//  DetalleListaViewController.swift
//  vmc_app
//
//  Created by macbook3 on 4/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class DetalleListaViewController: UITableViewController, UISearchResultsUpdating {
    
    var window : UIWindow = UIApplication.sharedApplication().keyWindow!
    
    var width = UIScreen.mainScreen().bounds.size.width
    var menuRest:CGFloat = 60.0
    
    
    @IBOutlet weak var OpenSliderMenu: UIBarButtonItem!
    
    var ElementoLista = [""]
    var ElementosIdList = [""]
    var filtrarElementos  = [String]()
    var busquedaController : UISearchController!
    var resultatosController = UITableViewController()
    
    //almacena proveniente de view Lista (vista anterior)
    var nombreLista = ""
    var idList : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        if nombreLista.isEmpty {
            nombreLista = "List"
        }
        
        
        //cambio color y titulo del boton regresar
        self.navigationController!.navigationBar.tintColor = UIColor(hexaString: "#00FFD8")
        self.navigationController?.navigationBar.topItem?.title = ""
        
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //self.extendedLayoutIncludesOpaqueBars = true
        
        // START -- barra de busqueda
        self.resultatosController.tableView.dataSource = self
        self.resultatosController.tableView.delegate = self
        
        self.busquedaController = UISearchController(searchResultsController: self.resultatosController)
        self.tableView.tableHeaderView = self.busquedaController.searchBar
        self.busquedaController.searchResultsUpdater = self
        self.busquedaController.dimsBackgroundDuringPresentation = false
        // END -- barra de busqueda
        
        self.busquedaController.searchBar.barTintColor = UIColor.whiteColor()
        self.busquedaController.searchBar.tintColor = UIColor.grayColor()
        self.busquedaController.searchBar.sizeToFit()
        //self.busquedaController.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        
        let searchIcon = UIImage(named: "lupa_blanca-Small")
        self.busquedaController.searchBar.setImage(searchIcon, forSearchBarIcon: .Search, state: .Normal)
        let clearIcon = UIImage(named: "cerrar_blanco-Small")
        self.busquedaController.searchBar.setImage(clearIcon, forSearchBarIcon: .Clear, state: .Normal)
        
        // START -- Editar propiedades de campos de búsqueda
        if let searchField = self.busquedaController.searchBar.valueForKey("_searchField") as? UITextField  {
            if searchField.respondsToSelector(Selector("setAttributedPlaceholder:")) {
                
                let placeholder = "Search"
                let attributedString = NSMutableAttributedString(string: placeholder)
                let range = NSRange(location: 0, length: placeholder.characters.count)
                let color = UIColor(white: 1.0, alpha: 0.7)
                
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
                attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium", size: 15)!, range: range)
                searchField.attributedPlaceholder = attributedString
                
                searchField.clearButtonMode = UITextFieldViewMode.WhileEditing
                searchField.textColor = .whiteColor()
                searchField.textAlignment = .Left
                searchField.layer.cornerRadius = 14
            }
        }
        // END -- Editar propiedades de campos de búsqueda
        
        // START - cambio de color background textfield barra de busqueda
        for view in self.busquedaController.searchBar.subviews {
            for subview in view.subviews {
                if subview .isKindOfClass(UITextField) {
                    let textField: UITextField = subview as! UITextField
                    textField.backgroundColor = UIColor(hexaString: "#0198F3")
                }
            }
        }
        // END - cambio de color background textfield barra de busqueda
        
        self.busquedaController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.title = nombreLista
        
        definesPresentationContext = true
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        
        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/contacts_list/\(idList)"
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
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .Alert)
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
                                self.ElementoLista.removeAll()
                                let espacio =  " ";
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    for item in json {
                                        if let Id = item.valueForKey("id") {
                                            self.ElementosIdList.append(Id as! String)
                                            
                                            if let email = item.valueForKey("email") {
                                                self.ElementoLista.append(email as! String)
                                            }else{
                                                self.ElementoLista.append(espacio)
                                            }
                                        }
                                    }//fin for
                                    
                                    
                                    //esaparecer loading
                                    self.dismissViewControllerAnimated(false, completion: nil)
                                    self.tableView.reloadData()
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
                NSLog("Response code: %ld", res.statusCode)
                if res.statusCode == 401 {
                    dispatch_async(dispatch_get_main_queue()){
                        let appDomain = NSBundle.mainBundle().bundleIdentifier
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                        //esaparecer loading
                        self.dismissViewControllerAnimated(false, completion: nil)
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
        
        self.tableView.backgroundColor = UIColor(hexaString: "#F8F8F8")
        self.tableView.separatorColor = UIColor.lightGrayColor()
        
        
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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filtrarElementos = self.ElementoLista.filter{ (varLista:String) -> Bool in
            var pase = "N"
            if let varBusqueda = self.busquedaController.searchBar.text?.lowercaseString {
                pase = "S"
                print("\(varBusqueda)")
            }else{
                pase = "N"
                
            }
            
            var retornar = false
            if pase == "S" {
                if varLista.lowercaseString.containsString(self.busquedaController.searchBar.text!.lowercaseString) {
                    retornar = true
                }else{
                    retornar = false
                }
            
            }
            
            return retornar
        }
        self.resultatosController.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if tableView == self.tableView {
            count = self.ElementoLista.count
        }else{
            count = self.filtrarElementos.count
        }
        return count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomDetalleListaViewController = self.tableView.dequeueReusableCellWithIdentifier("cellDetalleLista")! as! CustomDetalleListaViewController
        //let cell = UITableViewCell()
        if tableView == self.tableView {
            cell.nombreEmail.text = self.ElementoLista[indexPath.row]
            
            //cell.textLabel?.text = self.ElementoLista[indexPath.row]
        }else{
            cell.nombreEmail.text = self.filtrarElementos[indexPath.row]
            //cell.textLabel?.text = self.filtrarElementos[indexPath.row]
        }
        cell.nombreEmail.font = UIFont(name: "HelveticaNeue-Thin", size: 16)!
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    deinit{
        if let superView = busquedaController.view.superview
        {
            superView.removeFromSuperview()
        }
    }

}
