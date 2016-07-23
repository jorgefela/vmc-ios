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
        print(indexPath.row)
        cell.TextElementoMenu.text = self.ElementosMenu[indexPath.row]
       
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //segue_a_campanias
        dispatch_async(dispatch_get_main_queue()){
            //self.performSegueWithIdentifier("segue_a_campanias", sender: self)
            
        }
        TablaElementoMenu.deselectRowAtIndexPath(indexPath, animated: true)
    }
}