//
//  SliderMenuViewController.swift
//  vmc_app
//
//  Created by macbook3 on 22/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class SliderMenuViewController: UIViewController{
    
    @IBOutlet weak var ImagenPerfil: UIImageView!
    
    
    //let screenWidth = screenSize.width * 0.75
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ImagenPerfil.layer.cornerRadius = self.ImagenPerfil.frame.size.width / 2
        self.ImagenPerfil.clipsToBounds = true
        print("cargue imagen")
    }
}