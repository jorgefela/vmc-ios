//
//  UIFont+Utils.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func SFTextRegular(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.SFTextRegular, size: size)
    }
    
    static func SFTextLight(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.SFTextLight, size: size)
    }
    
    static func SFTextMedium(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.SFTextMedium, size: size)
    }
    

}
