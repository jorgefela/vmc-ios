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
    
    //declaracion para mesajes
    let tituloMsg:String = "oops!"
    var mesnsajeMsg:String = "required field."
    let btnMsg:String = "OK"
    
    
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
        
        switch self.SegmentoSeleccion.selectedSegmentIndex {
        case 0:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            break
        case 1:
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
            vReturn = self.ElementosListNuevos.count
            break
        default:
            vReturn = self.ElementosListNuevos.count
        }
        
        return vReturn
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.TablaElementosListas.dequeueReusableCellWithIdentifier("CellAddList")!
        
        switch self.SegmentoSeleccion.selectedSegmentIndex {
        case 0:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            cell.textLabel!.text = ElementosListDefault[indexPath.row]
            break
        case 1:
            TextNombreNuevaLista.hidden = false
            BtnNuevo.hidden = false
            if self.ElementosListNuevos.count == 0 || self.ElementosListNuevos.isEmpty {
                cell.textLabel!.text = ""
            }else{
                cell.textLabel!.text = ElementosListNuevos[indexPath.row]
            }
            break
        default:
            TextNombreNuevaLista.hidden = true
            BtnNuevo.hidden = true
            cell.textLabel!.text = ElementosListDefault[indexPath.row]
        }
        
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
        TablaElementosListas.reloadData()
    }
    
    @IBAction func BtnAgregarNuevaLista(sender: UIButton) {
        
        let vNuevaLista = TextNombreNuevaLista.text!
        
        if vNuevaLista.isEmpty {
            
            FuncGlobal().alert(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self)
            
            TextNombreNuevaLista.becomeFirstResponder()
            
            
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
    
}
