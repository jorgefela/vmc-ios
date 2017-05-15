//
//  RegistroViewController.swift
//  Boilerplate
//
//  Created by macbook3 on 14/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation
import UIKit


class RegistroViewController: BaseViewController {
    
    // MARK: Static
    
    static let storyboardName = "RegistroStoryboard"
    
    // MARK: Properties
    
    var presenter: RegistroPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private
    private func setupView() {
        print("cargue setup registro")
        //setupBotonLogIn()
        
        //setupInputsBase()
        
    }
    
}
