//
//  Constants.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import UIKit
import Foundation
import Localize_Swift

enum Constants {
    
    enum URL {
        //static let baseURL = "http://hspay.herokuapp.com/v1/"
        //static let baseURL = "http://192.168.0.100/slim_app/"
        static let baseURL = "http://vmctechnology.com/api/v1/"
        static let signUp = baseURL + ""
        //static let login = baseURL + "auth/"
        static let login = baseURL + "public/login"
    }
    
    enum Storyboard {
        static let mainSearchStoryboard = "MainSearchStoryboard"
        static let mainBaseStoryboard = "MainBaseStoryboard"
    }
    
    enum ViewControllerIdentifier {
        static let mainSearchViewControllerIdentifier = "MainSearchViewControllerID"
        static let mainBaseViewControllerIdentifier = "MainBaseViewControllerID"
    }
    
    enum Label {
        static let padding = CGFloat(10)
        static let edgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    }
    
    enum Font {
        static let SFTextLight = "SanFranciscoText-Light"
        static let SFTextMedium = "SanFranciscoText-Medium"
        static let SFTextRegular = "SanFranciscoText-Regular"
    }

}
