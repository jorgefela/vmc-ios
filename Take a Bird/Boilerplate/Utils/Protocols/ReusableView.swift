//
//  ReusableView.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation
import UIKit


protocol ReusableView: class {}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
