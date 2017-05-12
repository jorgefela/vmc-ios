//
//  BaseViewController.swift
//  
//
//  Created by Hispanos Soluciones on 08/11/16.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation

protocol BaseView: class {
    func showLoading()
    func hideLoading()
    func showError(_ message: String?)
    func showMessage(_ message: String?, withTitle title: String?)
}
