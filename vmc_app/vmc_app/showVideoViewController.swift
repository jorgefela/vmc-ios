//
//  showVideoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 8/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class showVideoViewController: UIViewController{
    
    var moviePlayer:AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cargue controlador que muestra video")
        let videoURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(URL: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}