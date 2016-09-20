//
//  RecordVideoViewController.swift
//  vmc_app
//
//  Created by macbook3 on 20/9/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation

class RecordVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    let saveFileName = "/test.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}