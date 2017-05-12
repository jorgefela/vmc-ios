//
//  MainBaseContract.swift
//  Boilerplate
//
//  Created by macbook3 on 12/5/17.
//  Copyright © 2017 Hispanos Soluciones. All rights reserved.
//

import Foundation


protocol MainBaseView: BaseView {
    
}

protocol MainBasePresentation: class {
    func doSomething()
}

protocol MainBaseUseCase: class {
    
}

protocol MainBaseInteractorOutput: class {
    func onFetchProductsFailure(message: String)
}

protocol MainBaseWireframe: class {
    
}

