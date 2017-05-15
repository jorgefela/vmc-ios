//
//  RegistroContract.swift
//  Boilerplate
//
//  Created by macbook3 on 14/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation


protocol RegistroView: BaseView {
    // TODO: Declare view methods
}

protocol RegistroPresentation: class {
    // TODO: Declare presentation methods
    func pRegistrarUsuario()
}

protocol RegistroUseCase: class {
    // TODO: Declare use case methods
}

protocol RegistroInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol RegistroWireframe: class {
    // TODO: Declare wireframe methods
    //conexion entre modulos
    //static func setupModule() -> RegistroViewController
}
