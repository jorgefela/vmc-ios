//
//  HomePresenter.swift
//  Boilerplate
//
//  Created by macbook3 on 17/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation



class HomePresenter {
    
    // MARK: Properties
    
    weak var view: HomeView?
    var router: HomeWireframe?
    var interactor: HomeUseCase?
    
    
    
}


extension HomePresenter: HomePresentation {
    // TODO: implement presentation methods
    /*func pRegistrarUsuario(){
        print("registrando usuario a la api")
    }
    
    func pLogin(){
        // llamo a la vista de login
        router?.presentMainBaser()
    }*/
    
    
}


extension HomePresenter: HomeInteractorOutput {
    // TODO: implement interactor output methods
}
