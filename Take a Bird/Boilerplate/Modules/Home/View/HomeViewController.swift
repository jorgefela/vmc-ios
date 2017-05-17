//
//  HomeViewController.swift
//  Boilerplate
//
//  Created by macbook3 on 17/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

class HomeViewController: BaseViewController {
    
    // MARK: Static
    
    static let storyboardName = "HomeStoryboard"
    
    // MARK: IBOutlets
    
 
    
    
    // MARK: Properties
    
    var presenter: HomePresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    
    
    // MARK: Private
    private func setupView() {
        
        //setupBotonLogIn()
        
        //setupInputsBase()
        
    }
    
    // MARK: IBActions
    

    
    
    
}

extension  HomeViewController: MainBaseView {
    

    
}
