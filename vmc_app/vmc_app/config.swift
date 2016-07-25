//
//  config.swift
//  vmc_app
//
//  Created by macbook3 on 7/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

class Main {
    var urlBase:String
    var colorCabecera:UInt
    init(urlb:String, color:UInt) {
        self.urlBase = urlb
        self.colorCabecera = color
    }
}
var mainInstance = Main(
    urlb:"http://localhost:8888/modificacion/slim_app/", // url base
    color: 0x0A1429 //color para el navigation controller
)
//var mainInstance = Main(urlb:"http://localhost:8888/vmc-ios/webservice/slim_app/")