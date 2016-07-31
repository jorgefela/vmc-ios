//
//  SliderMenuViewController.swift
//  vmc_app
//
//  Created by macbook3 on 22/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
import Kingfisher

class SliderMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ImagenPerfil: UIImageView!
    @IBOutlet weak var nombrePerfil: UILabel!
    
    @IBOutlet weak var TablaElementoMenu: UITableView!
    
    
    
    //obtener medidas de pantalla
    var width = UIScreen.mainScreen().bounds.size.width
    
    var window :UIWindow = UIApplication.sharedApplication().keyWindow!
    
    var ElementosMenu = [
        "List",
        "Profile",
        "How this work",
        "Contact us",
        "Logout"
    ]
    var IconosMenu = [
        "List",
        "Profile",
        "How this work",
        "Contact us",
        "Logout"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        dispatch_async(dispatch_get_main_queue(), {
            if prefs.valueForKey("PHOTO") as! String != ""{
                let foto = prefs.valueForKey("PHOTO") as! String
                var uPhoto = "\(mainInstance.urlImagePerfil)\(foto)"
                uPhoto = uPhoto.convertirEspaciosGet()
                self.ImagenPerfil.kf_setImageWithURL(NSURL(string: uPhoto),
                    placeholderImage: nil,
                    optionsInfo: nil,
                    progressBlock: { (receivedSize, totalSize) -> () in
                        print("Download Progress: \(receivedSize)/\(totalSize)")
                    },
                    completionHandler: { (image, error, cacheType, imageURL) -> () in
                        print("")
                    }
                )
            }else{
                self.ImagenPerfil.image = UIImage(named: "photo_perfil.png")
            }
            
        })
        
        self.ImagenPerfil.layer.cornerRadius = self.ImagenPerfil.frame.size.width / 2
        self.ImagenPerfil.layer.borderColor = UIColor( red: 190/255, green: 190/255, blue:190/255, alpha: 1.0 ).CGColor
        self.ImagenPerfil.layer.borderWidth = 3.0
        self.ImagenPerfil.clipsToBounds = true
        let nombre = prefs.valueForKey("NAME") as! String
        self.nombrePerfil.text = nombre
    }
    
    //metodos table view cell
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ElementosMenu.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomSliderMenuViewController = self.TablaElementoMenu.dequeueReusableCellWithIdentifier("CellElementoMenu")! as! CustomSliderMenuViewController
        cell.TextElementoMenu.text = self.ElementosMenu[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // let myCellShow:CustomSliderMenuViewController = tableView.cellForRowAtIndexPath(indexPath) as! CustomSliderMenuViewController

        dispatch_async(dispatch_get_main_queue()){
            
            if self.ElementosMenu[indexPath.row] == "Logout" || self.ElementosMenu[indexPath.row] == "logout" {
                let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                //cierro sesion
                let appDomain = NSBundle.mainBundle().bundleIdentifier
                NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                //redirigo a la vista login
                UIView.transitionWithView(self.window, duration: 0, options: UIViewAnimationOptions.TransitionNone, animations: {() -> Void in self.window.rootViewController = loginViewController}, completion: nil)
            }
            else if self.ElementosMenu[indexPath.row] == "Contact us" || self.ElementosMenu[indexPath.row] == "contact us" {
                print("cargue Contact us")
            }
            else if self.ElementosMenu[indexPath.row] == "How this work" || self.ElementosMenu[indexPath.row] == "how this work" {
                print("cargue How this work")
            }
            else if self.ElementosMenu[indexPath.row] == "Profile" || self.ElementosMenu[indexPath.row] == "profile" {
                print("cargue Profile")
                self.performSegueWithIdentifier("segueProfile", sender: self)
            }
            else if self.ElementosMenu[indexPath.row] == "List" || self.ElementosMenu[indexPath.row] == "list" {
                self.performSegueWithIdentifier("segueLista", sender: self)
            }
            
        }
        TablaElementoMenu.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}