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
    
    func doSomething() {
        print("te encontre")
        view?.showMessage("I'm doing something!!", withTitle: "Hey")
    }
    
    //TODO: Implementar otros métodos de presenter->view aqui
    
}

extension MainBasePresenter: MainBaseInteractorOutput {
    
    func onFetchProductsFailure(message: String) {
        view?.showError(message)
    }
    
    //TODO: Implementar otros métodos de interactor->presenter aquí
    
}
