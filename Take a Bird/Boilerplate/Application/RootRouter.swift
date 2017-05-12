//
//  RootWireframe.swift
//
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import UIKit

class RootRouter: NSObject {
    
   /*
 func presentFirstScreen(inWindow window: UIWindow) {
        presentMainSearchScreen()
    }
 */
    
    func presentFirstScreen(inWindow window: UIWindow) {
        presentMainBaseScreen()
    }
    /*
    private func presentMainSearchScreen() {
        let mainSearchViewController = MainSearchRouter.setupModule()
        presentView(mainSearchViewController)
    }*/
    
    private func presentMainBaseScreen() {
        let mainBaseViewController = MainBaseRouter.setupModule()
        presentView(mainBaseViewController)
    }
    
    private func presentView(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window! else { return }
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        window.rootViewController = viewController
    }    
}
