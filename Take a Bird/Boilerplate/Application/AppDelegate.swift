//
//  AppDelegate.swift
//  
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBarFont()
        setupBackButtonAppearance()
        presentInitialScreen()
        return true
    }
    
    // MARK: Private Methods
    
    func presentInitialScreen() {
        let rootRouter = RootRouter()
        rootRouter.presentFirstScreen(inWindow: window!)
    }
    
    fileprivate func setupNavigationBarFont() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
        navigationBarAppearace.barTintColor = .white
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
    }
    
    fileprivate func setupBackButtonAppearance() {
        UINavigationBar.appearance().backIndicatorImage = UIImage.backIcon
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage.backIcon
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for: .default)
    }
}
