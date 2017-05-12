//
//  UserProfile.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class UserProfile: Object, Mappable {
    
    dynamic var name: String?
    dynamic var email: String?
    dynamic var token: String?
    dynamic var password: String?
       
    convenience required init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "email"
    }
    
    // MARK: Error fields
    
    var errors: ResponseErrors?
    
    // MARK: Mappable protocol
    
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        token <- map["token"]
        password <- map["password"]
        errors <- map["errors"]
    }
}
