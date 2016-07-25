//
//  config.swift
//  vmc_app
//
//  Created by macbook3 on 7/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

class Main {
    var urlBase:String
    var urlImages:String
    var colorCabecera:UInt
    var urlImagePerfil:String
    init(urlb:String, color:UInt, uImages:String, uImagePerfil:String) {
        self.urlBase = urlb
        self.colorCabecera = color
        self.urlImages = uImages
        self.urlImagePerfil = uImagePerfil

    }
}
var mainInstance = Main(
    urlb:"http://localhost:8888/modificacion/slim_app/", // url base
    color: 0x0A1429, //color para el navigation controller
    uImages: "https://www.vmctechnology.com/app/Uploads/images/",
    uImagePerfil: "https://www.vmctechnology.com/app/Uploads/user/"
)
//var mainInstance = Main(urlb:"http://localhost:8888/vmc-ios/webservice/slim_app/")