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
    var urlImagePreviewEmail:String
    init(urlb:String, color:UInt, uImages:String, uImagePerfil:String, uImagePreviewEmail:String) {
        self.urlBase = urlb
        self.colorCabecera = color
        self.urlImages = uImages
        self.urlImagePerfil = uImagePerfil
        self.urlImagePreviewEmail = uImagePreviewEmail
    }
}
var mainInstance = Main(
    urlb:"http://localhost/vmc-ios/webservice/slim_app/", // url base
    //urlb:"http://192.168.0.100/slim_app/", // url base
    //urlb:"http://vmctechnology.com/api/v1/", // url base produccion
    color: 1252671, //color para el navigation controller 1649746 0x0A1429 1252671
    uImages: "https://www.vmctechnology.com/app/Uploads/images/",
    uImagePerfil: "https://www.vmctechnology.com/app/Uploads/user/",
    uImagePreviewEmail: "https://www.vmctechnology.com/app/Emails/mail-img/"
)
//var mainInstance = Main(urlb:"http://localhost:8888/vmc-ios/webservice/slim_app/")