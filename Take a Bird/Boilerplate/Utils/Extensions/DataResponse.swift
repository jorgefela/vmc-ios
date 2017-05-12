//
//  DataResponse.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation
import Alamofire


extension DataResponse {
    
    var isSuccess: Bool {
        get {
            guard let statusCode = response?.statusCode else { return false }
            if 200 ... 299 ~= statusCode {
                return true
            } else {
                return false
            }
        }
    }
}
