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
        definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = !self.navigationController!.navigationBar.translucent
        self.resultatosController.tableView.dataSource = self
        self.resultatosController.tableView.delegate = self
        
        self.busquedaController = UISearchController(searchResultsController: self.resultatosController)
        self.tableView.tableHeaderView = self.busquedaController.searchBar
        self.busquedaController.searchResultsUpdater = self
        self.busquedaController.dimsBackgroundDuringPresentation = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filtrarElementos = self.ElementoLista.filter{ (varLista:String) -> Bool in
            print("\(self.busquedaController.searchBar.text!.lowercaseString)")
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
