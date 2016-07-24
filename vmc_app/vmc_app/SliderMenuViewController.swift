//
//  SliderMenuViewController.swift
//  vmc_app
//
//  Created by macbook3 on 22/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class SliderMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var ImagenPerfil: UIImageView!
    
    @IBOutlet weak var TablaElementoMenu: UITableView!
    
    
    
    //obtener medidas de pantalla
    var width = UIScreen.mainScreen().bounds.size.width
    
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
        
        self.ImagenPerfil.layer.cornerRadius = self.ImagenPerfil.frame.size.width / 2
        self.ImagenPerfil.clipsToBounds = true
        print("cargue imagen")
    }
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
                print("cerre sesion LoginView")
                let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView")
                print(loginViewController)
                self.performSegueWithIdentifier("LoginView", sender: self)
                //UIView.transitionWithView(self, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {() -> Void in self.window.rootViewController = loginViewController}, completion: nil)
                //self.rootViewController = loginViewController
                //self.navigationController?.popToRootViewControllerAnimated(true)
            }
            //self.performSegueWithIdentifier("segue_a_campanias", sender: self)
            
        }
        TablaElementoMenu.deselectRowAtIndexPath(indexPath, animated: true)
    }
}