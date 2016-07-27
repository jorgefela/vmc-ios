//
//  AddListViewController.swift
//  vmc_app
//
//  Created by macbook3 on 26/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController {
    
    @IBOutlet weak var TextNombreLista: UITextField!
    
    @IBOutlet weak var SegmentoSeleccion: UISegmentedControl!
    
    @IBOutlet weak var TextNombreNuevaLista: UITextField!
    
    @IBOutlet weak var TablaElementosListas: UITableView!
    
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
        " "
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TablaElementosListas.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellAddList")
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
    }
    
    //metodos UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ElementosListDefault.count
        //return self.ElementosListNuevos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.TablaElementosListas.dequeueReusableCellWithIdentifier("CellAddList")!

        
        cell.textLabel!.text = ElementosListDefault[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        

        dispatch_async(dispatch_get_main_queue()){
            //self.id = self.listId[indexPath.row]
            //self.nombreE = self.ListEmailNombre[indexPath.row]
            //self.subjectE = self.ListEmailDescripcion[indexPath.row]
            //self.performSegueWithIdentifier("segue_a_campanias", sender: self)
            
        }
        TablaElementosListas.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func BtnSegmentoSelccion(sender: UISegmentedControl) {
    }
    
    @IBAction func BtnAgregarNuevaLista(sender: UIButton) {
    }
}
