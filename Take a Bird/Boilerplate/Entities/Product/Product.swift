//
//  Product.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Localize_Swift

class Product: Object, Mappable {

    dynamic var id = 0
    dynamic var code = 0
    dynamic var name: String?
    
    // MARK: Init methods
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Mapping variables
    
    func mapping(map: Map) {
        
        // Main Search Data
        
        id <- map["id"]
        code <- map["code"]
        name <- map["name"]
    }
}
