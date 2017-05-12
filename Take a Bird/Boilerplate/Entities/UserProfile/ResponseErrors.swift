//
//  LoginSingupErrors.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation
import ObjectMapper


class ResponseErrors: Mappable {
    
    var emailTakenOrInvalid: [String]?
    var passwordIssue: [String]?
    var userIsInvalid: [String]?
    
    required convenience init?(map: Map) {
        self.init()
    }

    // Mappable protocol
    
    func mapping(map: Map) {
        emailTakenOrInvalid <- map["email"]
        passwordIssue <- map["password"]
        userIsInvalid <- map["partner_id"]
    }
}
