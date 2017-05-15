//
//  RegistroRouter.swift
//  Boilerplate
//
//  Created by macbook3 on 14/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation
import UIKit

class RegistroRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> RegistroViewController {
        
        //MainBaseViewController.storyboardName
        //RegistroViewController.storyboardName
        
        //let viewController:RegistroViewController = UIStoryboard(name: "RegistroStoryboard").instantiateViewController() as! RegistroViewController
        //let viewController = UIStoryboard(name: RegistroViewController.storyboardName, bundle: nil).instantiateViewController() as RegistroViewController
        
        //let storyBoard = UIStoryboard(name: MainBaseViewController.storyboardName, bundle: nil)
        
        //Here instantiate view controller with the storyboard instance,
        //Before that create a storyboardId for the corresponding view controller.
        //let viewController = storyBoard.instantiateViewController(withIdentifier: RegistroViewController.storyboardName) as! RegistroViewController
        
        let storyboard = UIStoryboard(name: MainBaseViewController.storyboardName, bundle: nil)
        // 'storyboardName' contains "Main_iPhone"
        //let storyboardName : String = storyboard.value(forKey: RegistroViewController.storyboardName) as! String
        
        let viewController = storyboard.instantiateViewController(withIdentifier: RegistroViewController.storyboardName) as! RegistroViewController
        
      
        
        let presenter = RegistroPresenter()
        let router = RegistroRouter()
        let interactor = RegistroInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = (viewController  as! RegistroView)
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}


extension RegistroRouter: RegistroWireframe {
    // TODO: Implement wireframe methods
}
