//
//  AddListViewController.swift
//  vmc_app
//
//  Created by macbook3 on 26/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var TextNombreLista: UITextField!
    
    @IBOutlet weak var SegmentoSeleccion: UISegmentedControl!
    
    @IBOutlet weak var TextNombreNuevaLista: UITextField!
    
    @IBOutlet weak var TablaElementosListas: UITableView!
    
    @IBOutlet weak var BtnNuevo: UIButton!
    
    var window :UIWindow = UIApplication.sharedApplication().keyWindow!
    
    
    var ElementosListDefault = [
        "Email Address",
        "First Name",
        "Last Name",
        "Organization Name",
        "Job Title",
        "Phone Number",
        "Street Address",
        "City",
        "State/Province",
        "Zip/Post Code"
    ]
    
    var ElementosListNuevos = [
        ""
    ]
    
    var ElementosListExtra = [
        "yo"
    ]
    
    //declaracion para mesajes
    var tituloMsg:String = "oops!"
    var mesnsajeMsg:String = "Empty name list."
    let btnMsg:String = "OK"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TablaElementosListas.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellAddList")
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //let estaLogueado:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        //if (estaLogueado != 1) {
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        print("\(idUser) \(keyServer)")
        //}
        
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
        
        self.SegmentoSeleccion.setEnabled(false , forSegmentAtIndex: 1)
        switch self.SegmentoSeleccion.selectedSegmentIndex {
        case 0:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            break
        case 1:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            break
        case 2:
            TextNombreNuevaLista.becomeFirstResponder()
            TextNombreNuevaLista.hidden = false
            BtnNuevo.hidden = false
            break
        default:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
        }
        
    }
    
    //metodos UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var vReturn = 0
        
        switch self.SegmentoSeleccion.selectedSegmentIndex {
        case 0:
            vReturn = self.ElementosListDefault.count
            break
        case 1:
            vReturn = self.ElementosListExtra.count
            break
        case 2:
            vReturn = self.ElementosListNuevos.count
            break
        default:
            vReturn = self.ElementosListDefault.count
        }
        
        return vReturn
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.TablaElementosListas.dequeueReusableCellWithIdentifier("CellAddList")!
        
        switch self.SegmentoSeleccion.selectedSegmentIndex {
        case 0:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            cell.textLabel!.text = self.ElementosListDefault[indexPath.row]
            break
        case 1:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            cell.textLabel!.text = self.ElementosListExtra[indexPath.row]
            break
        case 2:
            TextNombreNuevaLista.hidden = false
            BtnNuevo.hidden = false
            if self.ElementosListNuevos.count == 0 || self.ElementosListNuevos.isEmpty {
                cell.textLabel!.text = ""
            }else{
                cell.textLabel!.text = self.ElementosListNuevos[indexPath.row]
                
            }
            break
        default:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            cell.textLabel!.text = ElementosListDefault[indexPath.row]
        }
        
        cell.textLabel!.font = UIFont(name:"HelveticaNeue-Thin", size:17)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(self.SegmentoSeleccion.selectedSegmentIndex)
        dispatch_async(dispatch_get_main_queue()){
            //self.id = self.listId[indexPath.row]
            //self.nombreE = self.ListEmailNombre[indexPath.row]
            //self.subjectE = self.ListEmailDescripcion[indexPath.row]
            //self.performSegueWithIdentifier("segue_a_campanias", sender: self)
            
        }
        TablaElementosListas.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func BtnSegmentoSelccion(sender: UISegmentedControl) {
        
        switch self.SegmentoSeleccion.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        case 2:
            TextNombreNuevaLista.becomeFirstResponder()
            break
        default:
            print("default")
        }
        TablaElementosListas.reloadData()
    }
    
    @IBAction func BtnAgregarNuevaLista(sender: UIButton) {
        
        let vNuevaLista = TextNombreNuevaLista.text!
        
        if vNuevaLista.isEmpty {
            
            mesnsajeMsg = "Name field empty."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus:self.TextNombreNuevaLista)
            
        }else{
            
            if self.ElementosListNuevos[0].isEmpty {
                self.ElementosListNuevos.removeAll()
            }
            
            self.ElementosListNuevos.append(vNuevaLista)
            TextNombreNuevaLista.text = ""
            TextNombreNuevaLista.becomeFirstResponder()
            TablaElementosListas.reloadData()
            
        }
    }
    
    
    @IBAction func GuardarLista(sender: UIButton) {
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let idUser:Int = prefs.integerForKey("IDUSER") as Int
        let keyServer:String = (prefs.valueForKey("KEY") as? String)!
        var postString = "id_user=\(idUser)"
        let nombreLista = TextNombreLista.text!
        
        if nombreLista.isEmpty {
            
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus:self.TextNombreLista)
        
        }else{
            
            postString += "&nombre_lista=\(nombreLista)"
            
            // START -- validar nueva lista
            if !self.ElementosListNuevos[0].isEmpty {
                
                postString += "&campos_extras="
                
                var index = 0
                
                for item in ElementosListNuevos {
                    
                    if index == 0 {
                        postString += "\(item)"
                    }else{
                        postString += "||\(item)"
                    }
                    
                    
                    index = index + 1
                    
                }//fin for
                
                print(postString)
                
            }
            // END -- validar nueva lista
            
        }
        
        if !nombreLista.isEmpty {
            
            let url_path: String = mainInstance.urlBase + "public/list"
            let url = NSURL(string: url_path)
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            
            request.HTTPMethod = "POST"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("\(keyServer)", forHTTPHeaderField: "key")
            
            let session = NSURLSession.sharedSession()
            
            // START -- peticion
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                
                let res = response as! NSHTTPURLResponse!;
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    if error != nil{print(error?.localizedDescription)}
                    
                    do{
                        
                        if let dictionary_result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    
                                    let json2 = dictionary_result["rows"]! as! Int
                                    
                                    if  json2 > 0 {
                                        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("prueba2")
                                        //segueLista
                                        
                                        self.mesnsajeMsg = dictionary_result["message"]! as! String
                                        self.tituloMsg = "Great!"
                                        let popUp = UIAlertController(title: self.tituloMsg, message: self.mesnsajeMsg, preferredStyle: UIAlertControllerStyle.Alert)
                                        popUp.addAction(UIAlertAction(title: self.btnMsg, style: UIAlertActionStyle.Default, handler: {alertAction in UIView.transitionWithView(self.window, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
                                        }))
                                        self.presentViewController(popUp, animated: true, completion: nil)
                                        
                                    }else{
                                        print("error aqui 2 ")
                                    }
                                    
                                    PreLoading().hideLoading()
                                    
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
            // END -- peticion
        }
   
        
    }//func GuardarLista
    
    @IBAction func IrAlPanel(sender: UIBarButtonItem) {
        let segueViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
        UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = segueViewController}, completion: nil)
    }
    
    
    @IBAction func Regresar(sender: UIBarButtonItem) {
        
            print("regrese")
            if let navigationController = self.navigationController
            {
                dispatch_async(dispatch_get_main_queue()){
                    navigationController.popViewControllerAnimated(true)
                }
            }
        
    }
    
    
    
    
}
