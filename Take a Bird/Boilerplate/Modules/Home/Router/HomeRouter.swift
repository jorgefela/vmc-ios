//
//  HomeRouter.swift
//  Boilerplate
//
//  Created by macbook3 on 17/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> HomeViewController {
        
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: HomeViewController.storyboardName, bundle: nil)
        let viewController : HomeViewController = mainView.instantiateViewController(withIdentifier: HomeViewController.storyboardName) as! HomeViewController
        let presenter = HomePresenter()
        let router = HomeRouter()
        let interactor = HomeInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController as? HomeView
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        interactor.output = presenter
        
        return viewController
    }
}


extension HomeRouter: HomeWireframe {
    // TODO: Implement wireframe methods
    /*func presentMainBaser() {
        
        let window :UIWindow = UIApplication.shared.keyWindow!
        let rootRouter = RootRouter()
        rootRouter.presentFirstScreen(inWindow: window)
        
    }*/
}
