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
    
    var LabelArray = ["email", "name", "last name", "phone"]
    var CampoArray = ["", "", "", ""]
    
    @IBOutlet weak var tableViewContacto: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewContacto.beginUpdates()
        //self.tableViewContacto.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableViewContacto.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableViewContacto.endUpdates()
        print("\(filaSeleccionada) \(idList)")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        count = self.LabelArray.count
        
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomEditContactoViewController = self.tableViewContacto.dequeueReusableCellWithIdentifier("cell_edit_contact")! as! CustomEditContactoViewController
        
        cell.nombreCampo.text = self.LabelArray[indexPath.row]
        

        cell.nombreCampo.font = UIFont(name: "HelveticaNeue", size: 16)!
        cell.nombreCampo.textColor = UIColor.grayColor()
        let separatorLineView: UIView = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 2))
        separatorLineView.backgroundColor = UIColor.grayColor()
        cell.contentView.addSubview(separatorLineView)
        //separatorLineView.backgroundColor = UIColor(red: 247, green: 247, blue: 247)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableViewContacto.endUpdates()
        
    }
    

    
    
}
