//
//  RegistroPresenter.swift
//  Boilerplate
//
//  Created by macbook3 on 14/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation



class RegistroPresenter {
    
    // MARK: Properties
    
    weak var view: RegistroView?
    var router: RegistroWireframe?
    var interactor: RegistroUseCase?
    
    
    
}


extension RegistroPresenter: RegistroPresentation {
    // TODO: implement presentation methods
    func pRegistrarUsuario(){
        print("registrando usuario a la api")
    }
    
    func pLogin(){
        // llamo a la vista de login
        router?.presentMainBaser()
    }
    
    
}


extension RegistroPresenter: RegistroInteractorOutput {
    // TODO: implement interactor output methods
}


