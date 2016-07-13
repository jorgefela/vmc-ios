//
//  CustomTableViewCellCampaigns.swift
//  vmc_app
//
//  Created by macbook3 on 11/7/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class CustomTableViewCellCampaigns: UITableViewCell {
    
    @IBOutlet weak var LabelNombreCampaing: UILabel!

    @IBOutlet weak var dataDelivery: UILabel!
    @IBOutlet weak var dataOpens: UILabel!
    @IBOutlet weak var dataPlays: UILabel!
    @IBOutlet weak var dataClick: UILabel!
    @IBOutlet weak var dataBounces: UILabel!
    @IBOutlet weak var dataSpam: UILabel!
    
    @IBOutlet weak var viewSubCell: UIView!
    
    class var expandirAltura: CGFloat{ get { return 200 }}
    class var defaultAltura:  CGFloat{ get { return 44  }}
    
    func checkAltura(){
        viewSubCell.hidden = (frame.size.height < CustomTableViewCellCampaigns.expandirAltura)
    }
    
    func aplicarCambioFram(){
        print("registre frame")
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        checkAltura()
    }
    
    func ignorarCambioFram(){
        print("elimine frame")
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkAltura()
        }
    }
}