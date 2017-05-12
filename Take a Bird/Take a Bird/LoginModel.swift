//
//  LoginModel.swift
//  Take a Bird
//
//  Created by Daniel Garcia on 9/5/17.
//  Copyright © 2017 Hispano Soluciones, C.A. All rights reserved.
//

import Foundation
import ObjectMapper

struct LoginModel {
    var id = 0
    var user = ""
    var pass = ""
    var thumbImageUrl = ""
}

extension LoginModel: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id       <- map["id"]
        title     <- map["title"]
        imageUrl     <- map["url"]
        thumbImageUrl     <- map["thumbUrl"]
    }
    
}
