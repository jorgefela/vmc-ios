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
    

    
    
}
