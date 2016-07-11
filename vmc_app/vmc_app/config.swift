//
//  config.swift
//  vmc_app
//
//  Created by macbook3 on 7/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

class Main {
    var urlBase:String
    init(urlb:String) {
        self.urlBase = urlb
    }
}
var mainInstance = Main(urlb:"http://localhost:8888/modificacion/slim_app/")
//var mainInstance = Main(urlb:"http://localhost:8888/vmc-ios/webservice/slim_app/")