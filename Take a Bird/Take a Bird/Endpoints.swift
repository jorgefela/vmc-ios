//
//  Endpoints.swift
//  Take a Bird
//
//  Created by macbook3 on 9/5/17.
//  Copyright © 2017 Hispano Soluciones, C.A. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "https://fierce-cove-29863.herokuapp.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Posts: Endpoint {
        case fetch
        
        public var path: String {
            print("aquiiiiiii: \(Posts.fetch)")
            switch self {
            case .fetch: return "/getAllPosts"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}
