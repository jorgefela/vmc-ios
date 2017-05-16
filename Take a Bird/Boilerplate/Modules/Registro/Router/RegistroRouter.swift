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
        
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: RegistroViewController.storyboardName, bundle: nil)
        let viewController : RegistroViewController = mainView.instantiateViewController(withIdentifier: RegistroViewController.storyboardName) as! RegistroViewController
        let presenter = RegistroPresenter()
        let router = RegistroRouter()
        let interactor = RegistroInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController as? RegistroView
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        interactor.output = presenter
        
        return viewController
    }
}


extension RegistroRouter: RegistroWireframe {
    // TODO: Implement wireframe methods
    func presentMainBaser() {
        
        let window :UIWindow = UIApplication.shared.keyWindow!
        let rootRouter = RootRouter()
        rootRouter.presentFirstScreen(inWindow: window)
    }
}
