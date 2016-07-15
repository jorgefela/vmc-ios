//
//  VideoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 8/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var TableViewVideo: UITableView!
    var ListVideos = ["Cargando..."]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cargue controlador de video")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListVideos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.TableViewVideo.dequeueReusableCellWithIdentifier("VideoCell")!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        TableViewVideo.deselectRowAtIndexPath(indexPath, animated: true)
    }
}