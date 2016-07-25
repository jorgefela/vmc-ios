//
//  ListViewController.swift
//  vmc_app
//
//  Created by macbook3 on 24/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TablaList: UITableView!
    
    var ElementosList = [
        "elemento 1",
        "elemento 2",
        "elemento 3",
        "elemento 4",
        "elemento 5"
    ]
    
    var ElementosCantList = [
        "323",
        "435",
        "22",
        "77",
        "43"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        self.navigationController!.navigationBar.translucent = false
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
    }
    
    // metodos tableview controllers
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ElementosList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell:CustomListViewController = self.TablaList.dequeueReusableCellWithIdentifier("cellTablaListCustom")! as! CustomListViewController
        cell.nombreLista.text = self.ElementosList[indexPath.row]
        cell.cantSubcriptores.text = self.ElementosCantList[indexPath.row]
        //cell.TextBotonLista.text = "add contact"
    return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        TablaList.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
