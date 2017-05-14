//
//  MainBasePresenter.swift
//  Boilerplate
//
//  Created by macbook3 on 12/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

class MainBasePresenter {
    
    // MARK: Properties
    
    weak var view: MainBaseView?
    var router: MainBaseWireframe?
    var interactor: MainBaseUseCase?
    
}

extension MainBasePresenter: MainBasePresentation {
    
    //TODO: Implementar otros métodos de presenter->view aqui
    func pLogIn() {
        print("te encontre")
        view?.showMessage("Perfecto!!", withTitle: "Aqui")
    }
    
    func pRegister(){
        print("register en presente")
    }
    
}

extension MainBasePresenter: MainBaseInteractorOutput {
    
    func onFetchProductsFailure(message: String) {
        view?.showError(message)
    }
    
    //TODO: Implementar otros métodos de interactor->presenter aquí
    
}
