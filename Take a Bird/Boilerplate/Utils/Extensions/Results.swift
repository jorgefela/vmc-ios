//
//  Collection.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import RealmSwift

extension Results {
    
    func toArray () -> [Object] {
        var array = [Object]()
        for result in self {
            array.append(result)
        }
        return array
    }
}
