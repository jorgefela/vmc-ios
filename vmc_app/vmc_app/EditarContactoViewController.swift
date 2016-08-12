//
//  EditarContactoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 6/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

//devuelve los datos ingresados del nuevo contacto
@objc protocol datosEditContactoDelagado {
    func getDatosProtocol(email: String, filaSelcc:NSIndexPath, titulo: String)
}

class EditarContactoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
     weak var delagado : datosEditContactoDelagado?
    
    var window : UIWindow = UIApplication.sharedApplication().keyWindow!
    
    // fila proveniente del detalle 
    // de la lista contacto
    var filaSeleccionada : NSIndexPath?
    
    var idList : String = ""
    
    var id : String = ""
    
    var tituloLista : String = ""
    var email : String = ""
    
    var LabelArray = ["email", "name", "last name", "phone", ""]
    var CampoArray = ["", "", "", "", ""]
    
    @IBOutlet weak var tableViewContacto: UITableView!
    
    var index = 0
    
    //declaracion para mesajes
    var tituloMsg:String = "oops!"
    var mesnsajeMsg:String = "empty email."
    let btnMsg:String = "OK"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delagado?.getDatosProtocol("\(email)", filaSelcc: self.filaSeleccionada!, titulo: "\(self.tituloLista)")
       // self.navigationController?.navigationBar.topItem?.title = " "
        
        //let backImg: UIImage = UIImage(named: "flecha-izq-Small")!
        //UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImg, forState: .Normal, barMetrics: .Default)
        
        
        
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        //self.navigationController?.navigationBar.topItem?.title = ""
        //let backButton = UIBarButtonItem(title: "", style:.Plain, target: self, action: #selector(EditarContactoViewController.goBack))
        //self.navigationItem.leftBarButtonItem = backButton
        


        //PreLoading().showLoading()
        //definesPresentationContext = true
        self.tableViewContacto.beginUpdates()
        //self.tableViewContacto.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableViewContacto.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableViewContacto.endUpdates()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        
        let url_path: String = mainInstance.urlBase + "public/user/\(idUser)/contact/\(id)"
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
                                
                                let espacio =  "";
                                
                                if let json = dictionary_result["result"] as? NSArray  {
                                    for item in json {
                                        if let Id = item.valueForKey("id") {
                                            print("\(Id)")
                                            
                                            let campoEmail = NSIndexPath(forRow:0, inSection:0)
                                            let campoName = NSIndexPath(forRow:1, inSection:0)
                                            let campoLname = NSIndexPath(forRow:2, inSection:0)
                                            let campoPhone = NSIndexPath(forRow:3, inSection:0)
                                            
                                            let cellEmail = self.tableViewContacto.cellForRowAtIndexPath(campoEmail) as! CustomEditContactoViewController
                                            let cellName = self.tableViewContacto.cellForRowAtIndexPath(campoName) as! CustomEditContactoViewController
                                            let cellLname = self.tableViewContacto.cellForRowAtIndexPath(campoLname) as! CustomEditContactoViewController
                                            let cellPhone = self.tableViewContacto.cellForRowAtIndexPath(campoPhone) as! CustomEditContactoViewController
                                            
                                            if let email = item.valueForKey("email") {
                                                cellEmail.FieldContacto.text = email as? String
                                            }else{
                                                cellEmail.FieldContacto.text = espacio
                                            }
                                            
                                            if let name = item.valueForKey("name") {
                                                cellName.FieldContacto.text = name as? String
                                            }else{
                                                cellName.FieldContacto.text = espacio
                                            }
                                            
                                            if let lname = item.valueForKey("lname") {
                                                cellLname.FieldContacto.text = lname as? String
                                            }else{
                                                cellLname.FieldContacto.text = espacio
                                            }
                                            
                                            if let contact = item.valueForKey("contact") {
                                                cellPhone.FieldContacto.text = contact as? String
                                            }else{
                                                cellPhone.FieldContacto.text = espacio
                                            }
                                            
                                        }
                                    }//fin for
                                    
                                    
                                    //esaparecer loading
                                    //self.dismissViewControllerAnimated(false, completion: nil)
                                    PreLoading().hideLoading()
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
                        PreLoading().hideLoading()
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
                        PreLoading().hideLoading()
                        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                        
                    }
                }else{
                    dispatch_async(dispatch_get_main_queue()){
                        //esaparecer loading
                        //self.dismissViewControllerAnimated(false, completion: nil)
                        PreLoading().hideLoading()
                        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                        
                    }
                }
                
            }//fin validar response.status
            
        })
        
        task.resume()
        // END -- peticion
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //let backImg: UIImage = UIImage(named: "flecha-izq-Small")!
        //UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImg, forState: .Normal, barMetrics: .Default)
        //cambio color y titulo del boton regresar
        //self.navigationController!.navigationBar.tintColor = UIColor(hexaString: "#00FFD8")
        //self.navigationController?.navigationBar.topItem?.title = " "
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        //let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        //self.navigationItem.backBarButtonItem = backItem
        
        self.navigationController!.navigationBar.tintColor = UIColor(hexaString: "#00FFD8")
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "flecha-izq-Small")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "flecha-izq-Small")
        //self.navigationController?.navigationBar.topItem?.title = ""
        if let navButtons = self.navigationController?.navigationBar.items {
            print("entre aqui")
            if navButtons.count > 0 {
                navButtons[0].title = ""
            }
        }
        
        //let backImg: UIImage = UIImage(named: "flecha-izq-Small")!
        //UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        //UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImg, forState: .Normal, barMetrics: .Default)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.LabelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomEditContactoViewController = self.tableViewContacto.dequeueReusableCellWithIdentifier("cell_edit_contact")! as! CustomEditContactoViewController
        if index != 0 {
            let separatorLineView: UIView = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 1))
            separatorLineView.backgroundColor = UIColor(hexaString: "#D8D8D8")
            cell.contentView.addSubview(separatorLineView)
        }
        
        
        cell.nombreCampo.text = self.LabelArray[indexPath.row]
        
        cell.nombreCampo.font = UIFont(name: "HelveticaNeue", size: 16)!
        cell.nombreCampo.textColor = UIColor.grayColor()
        index = index + 1
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableViewContacto.endUpdates()
        
    }
    
    @IBAction func guardar(sender: UIButton) {
        
        let campoEmail = NSIndexPath(forRow:0, inSection:0)
        let campoName = NSIndexPath(forRow:1, inSection:0)
        let campoLname = NSIndexPath(forRow:2, inSection:0)
        let campoPhone = NSIndexPath(forRow:3, inSection:0)
        
        let cellEmail = self.tableViewContacto.cellForRowAtIndexPath(campoEmail) as! CustomEditContactoViewController
        let cellName = self.tableViewContacto.cellForRowAtIndexPath(campoName) as! CustomEditContactoViewController
        let cellLname = self.tableViewContacto.cellForRowAtIndexPath(campoLname) as! CustomEditContactoViewController
        let cellPhone = self.tableViewContacto.cellForRowAtIndexPath(campoPhone) as! CustomEditContactoViewController
        
        let email:String = cellEmail.FieldContacto.text!
        let name:String = cellName.FieldContacto.text!
        let lName:String = cellLname.FieldContacto.text!
        let phone:String = cellPhone.FieldContacto.text!
        
        if email == " " || email.isEmpty {
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellEmail.FieldContacto)
        }
        
        else if !FuncGlobal().isValidEmail(email as String) {
            mesnsajeMsg = "invalid email."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellEmail.FieldContacto)
        }
            
        else if name == " " || name.isEmpty {
            mesnsajeMsg = "empty name."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellName.FieldContacto)
        }
            
        else if lName == " " || lName.isEmpty {
            mesnsajeMsg = "empty last name."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellLname.FieldContacto)
        }
            
        else if phone == " " || phone.isEmpty {
            mesnsajeMsg = "empty phone."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellPhone.FieldContacto)
        }else{
            
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let idUser:Int = prefs.integerForKey("IDUSER") as Int
            let keyServer:String = (prefs.valueForKey("KEY") as? String)!
            
            let postString = "id=\(id)&id_user=\(idUser)&email=\(email)&nombre=\(name)&lnombre=\(lName)&telefono=\(phone)"
            
            let url_path: String = mainInstance.urlBase + "public/contact"
            let url = NSURL(string: url_path)
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "PUT"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Accept")
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
                                    print(dictionary_result)
                                    self.mesnsajeMsg = dictionary_result["message"]! as! String
                                    self.tituloMsg = "Error!"
                                    let numReg = dictionary_result["rows"]! as! Int
                                    if numReg > 0 {
                                        if let json = dictionary_result["result"] as? NSArray  {
                                            self.delagado?.getDatosProtocol("\(email)", filaSelcc: self.filaSeleccionada!, titulo: self.tituloLista)
                                            print("\(json.valueForKey("id"))")
                                            self.tituloMsg = "Great!"
                                            
                                        }
                                        
                                        FuncGlobal().alert(self.tituloMsg, info: self.mesnsajeMsg, btnTxt: self.btnMsg, viewController: self)
                                    
                                        
                                        
                                        //esaparecer loading
                                        //self.dismissViewControllerAnimated(false, completion: nil)
                                        PreLoading().hideLoading()
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
                            PreLoading().hideLoading()
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
                            PreLoading().hideLoading()
                            let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                            UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                            
                        }
                    }else{
                        dispatch_async(dispatch_get_main_queue()){
                            //esaparecer loading
                            //self.dismissViewControllerAnimated(false, completion: nil)
                            PreLoading().hideLoading()
                            let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                            UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                            
                        }
                    }
                    
                }//fin validar response.status
                
            })
            
            task.resume()
            // END -- peticion
            
        }
        
        
    }


    @IBAction func eliminar(sender: UIButton) {
        print("eliminado")
    }
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}
