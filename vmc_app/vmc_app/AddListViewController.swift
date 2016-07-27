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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //START color navigation controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //END color navigation controller
    }
    
    @IBAction func BtnSegmentoSelccion(sender: UISegmentedControl) {
    }
    
    @IBAction func BtnAgregarNuevaLista(sender: UIButton) {
    }
}
