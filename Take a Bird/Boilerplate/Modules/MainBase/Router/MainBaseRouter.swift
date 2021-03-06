//
//  MainBaseRouter.swift
//  Boilerplate
//
//  Created by macbook3 on 12/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation
import UIKit

class MainBaseRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> MainBaseViewController {
        
        let viewController = UIStoryboard(name: MainBaseViewController.storyboardName, bundle: nil).instantiateViewController() as MainBaseViewController
        let presenter = MainBasePresenter()
        let router = MainBaseRouter()
        let interactor = MainBaseInteractor()
        
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}


extension MainBaseRouter: MainBaseWireframe {
    // TODO: Implement wireframe methods
    
    func presentRegister() {
        /*
         let window :UIWindow = UIApplication.shared.keyWindow!
         let rootRouter = RootRouter()
         rootRouter.presentRegisterScreen(inWindow: window)
         */
        let window = UIApplication.shared.windows[0] as UIWindow
        let mainBaseViewController = RegistroRouter.setupModule()
        
        UIView.transition(
            from: window.rootViewController!.view,
            to: mainBaseViewController.view,
            duration: 0.65,
            options:  .transitionFlipFromTop,
            completion: {
                finished in window.rootViewController = mainBaseViewController
        })
        
    }
    
 
 
}

