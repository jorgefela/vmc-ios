//
//  EditarContactoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 6/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
class EditarContactoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // fila proveniente del detalle 
    // de la lista contacto
    var filaSeleccionada : NSIndexPath?
    
    var idList : String = ""
    
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
        self.tableViewContacto.beginUpdates()
        //self.tableViewContacto.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableViewContacto.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableViewContacto.endUpdates()
        print("\(filaSeleccionada) \(idList)")
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
            
        else if name == "" || name.isEmpty {
            mesnsajeMsg = "empty name."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellName.FieldContacto)
        }
            
        else if lName == "" || lName.isEmpty {
            mesnsajeMsg = "empty last name."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellLname.FieldContacto)
        }
            
        else if phone == "" || phone.isEmpty {
            mesnsajeMsg = "empty phone."
            FuncGlobal().alertFocus(tituloMsg, info: mesnsajeMsg, btnTxt: btnMsg, viewController: self,toFocus: cellPhone.FieldContacto)
        }else{
            
            let postString = "email=\(email)&nombre=\(name)&lnombre=\(lName)&telefono=\(phone)"
            print(postString)
            
        }
        
        
    }


    @IBAction func eliminar(sender: UIButton) {
        print("eliminado")
    }
    
    
}
