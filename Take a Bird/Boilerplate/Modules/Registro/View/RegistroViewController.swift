//
//  RegistroViewController.swift
//  Boilerplate
//
//  Created by macbook3 on 14/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation
import UIKit


class RegistroViewController: BaseViewController {
    
    // MARK: Static
    
    static let storyboardName = "RegistroStoryboard"
    
    // MARK: IBOutlets
    
    @IBOutlet weak var txtPrimerNombre: UITextField!
    
    @IBOutlet weak var txtSegundoNombre: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtTelefono: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var txtRepetirPassword: UITextField!
    
    
    @IBOutlet weak var btnRegistrar: UIButton!
    
    
    // MARK: Properties
    
    var presenter: RegistroPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    
    
    // MARK: Private
    private func setupView() {
        print("cargue setup registro")
        setupBotonLogIn()
        
        setupInputsBase()
        
    }
    

    @IBAction func funcBtnRegistrar(_ sender: UIButton) {
    }
    
    
    @IBAction func funcLogin(_ sender: UIButton) {
    }
    
    
    
}

extension  RegistroViewController: MainBaseView {
    
    func setupBotonLogIn(){
        // TODO: Color de borde bonton
        btnRegistrar.backgroundColor = .clear
        btnRegistrar.layer.cornerRadius = 2
        btnRegistrar.layer.borderWidth = 1
        let verdeManzana : UIColor = UIColor.verdeManzana
        btnRegistrar.layer.borderColor = verdeManzana.cgColor
    }
    
    func setupInputsBase(){
        // TODO: Estilo Inputs Login
        // transparencia de bordes
        txtPrimerNombre.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        txtSegundoNombre.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        txtEmail.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        txtTelefono.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        txtPassword.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        txtRepetirPassword.backgroundColor = UIColor.white.withAlphaComponent(0.0000001)
        
        // Color de texto
        txtPrimerNombre.font = UIFont(name: "HelveticaNeue", size: 17)!
        txtSegundoNombre.font = UIFont(name: "HelveticaNeue", size: 17)!
        txtEmail.font = UIFont(name: "HelveticaNeue", size: 17)!
        txtTelefono.font = UIFont(name: "HelveticaNeue", size: 17)!
        txtPassword.font = UIFont(name: "HelveticaNeue", size: 17)!
        txtRepetirPassword.font = UIFont(name: "HelveticaNeue", size: 17)!
        
        
        txtPrimerNombre.textColor = UIColor.white
        txtSegundoNombre.textColor = UIColor.white
        txtEmail.textColor = UIColor.white
        txtTelefono.textColor = UIColor.white
        txtPassword.textColor = UIColor.white
        txtRepetirPassword.textColor = UIColor.white
    }

}
