//
//  PlainButtonCell.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation
import UIKit


class PlainButtonCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var bottomSeparator: UIView!
    
    var delegate: PlainButtonCellDelegate?
    
    func setup(delegate: PlainButtonCellDelegate?) {
        self.delegate = delegate
        setupButton()
        setupSeparator()
    }
    
    @IBAction func onButtonClicked(_ sender: UIButton) {
        print("presione boton")
        delegate?.onButtonClicked(self)
    }
    
    private func setupButton() {
        print("presione setupButton")

    }
    
    private func setupSeparator() {

    }
}
