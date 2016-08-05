//
//  DetalleListaViewController.swift
//  vmc_app
//
//  Created by macbook3 on 4/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class DetalleListaViewController: UITableViewController, UISearchResultsUpdating {
    
    var ElementoLista = ["daniel", "hnnia"]
    var filtrarElementos  = [String]()
    var busquedaController : UISearchController!
    var resultatosController = UITableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        //self.navigationController!.navigationBar.barTintColor = FuncGlobal().UIColorFromRGB(mainInstance.colorCabecera)
        //self.navigationController!.navigationBar.translucent = false
        
        //cambia color de texto navigation controller
        let colorTxtTitulo: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = colorTxtTitulo as? [String : AnyObject]
        //self.extendedLayoutIncludesOpaqueBars = true
        
        // START -- barra de busqueda
        self.resultatosController.tableView.dataSource = self
        self.resultatosController.tableView.delegate = self
        
        self.busquedaController = UISearchController(searchResultsController: self.resultatosController)
        self.tableView.tableHeaderView = self.busquedaController.searchBar
        self.busquedaController.searchResultsUpdater = self
        self.busquedaController.dimsBackgroundDuringPresentation = false
        // END -- barra de busqueda
        
        self.busquedaController.searchBar.barTintColor = UIColor.whiteColor()
        
        self.busquedaController.searchBar.tintColor = UIColor.grayColor()
        self.busquedaController.searchBar.sizeToFit()
        //self.busquedaController.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).backgroundColor = UIColor(hexaString: "#0198F3")
        let searchIcon = UIImage(named: "lupa_blanca-Small")
        self.busquedaController.searchBar.setImage(searchIcon, forSearchBarIcon: .Search, state: .Normal)
        
        let clearIcon = UIImage(named: "lupa_blanca-Small")
        self.busquedaController.searchBar.setImage(clearIcon, forSearchBarIcon: .Clear, state: .Normal)
        
        // Edit search field properties
        if let searchField = self.busquedaController.searchBar.valueForKey("_searchField") as? UITextField  {
            if searchField.respondsToSelector(Selector("setAttributedPlaceholder:")) {
                let placeholder = "Search"
                let attributedString = NSMutableAttributedString(string: placeholder)
                let range = NSRange(location: 0, length: placeholder.characters.count)
                let color = UIColor(white: 1.0, alpha: 0.7)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
                attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium", size: 15)!, range: range)
                searchField.attributedPlaceholder = attributedString
                
                searchField.clearButtonMode = UITextFieldViewMode.WhileEditing
                searchField.textColor = .whiteColor()
            }
        }
        
        self.busquedaController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        self.navigationItem.title = "New title"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filtrarElementos = self.ElementoLista.filter{ (varLista:String) -> Bool in
            var retornar = false
            if (self.busquedaController.searchBar.text?.lowercaseString) != nil {
                if varLista.lowercaseString.containsString(self.busquedaController.searchBar.text!.lowercaseString) {
                    retornar = true
                }else{
                    retornar = false
                }
            
            }
            return retornar
        }
        self.resultatosController.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if tableView == self.tableView {
            count = self.ElementoLista.count
        }else{
            count = self.filtrarElementos.count
        }
        return count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let cell = UITableViewCell()
        if tableView == self.tableView {
            cell.textLabel?.text = self.ElementoLista[indexPath.row]
        }else{
            cell.textLabel?.text = self.filtrarElementos[indexPath.row]
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
