//
//  PinkUILabel.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import UIKit

@IBDesignable
class ValidableUILabel: UILabel {
    
    var isItsTextFieldInvalid = true
    
    func resetLabelColor(toColor color: UIColor? = UIColor.bubbleGum) {
        isItsTextFieldInvalid ? (textColor = color) : ()
        isItsTextFieldInvalid = false
    }
    
    func highlightLabelColor() {
        textColor = UIColor.tomato
        isItsTextFieldInvalid = true
    }
}

