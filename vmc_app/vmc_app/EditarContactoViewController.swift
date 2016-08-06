//
//  EditarContactoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 6/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
class EditarContactoViewController: UIViewController {
    
    // fila proveniente del detalle 
    // de la lista contacto
    var filaSeleccionada : NSIndexPath?
    
    var idList : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(filaSeleccionada) \(idList)")
    }
    
}
