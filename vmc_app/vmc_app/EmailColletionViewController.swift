//
//  EmailColletionViewController.swift
//  vmc_app
//
//  Created by macbook3 on 13/12/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit

class EmailColletionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var screenWidth = UIScreen.mainScreen().bounds.size.width
    
    @IBOutlet weak var EmailCollectionData: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // auto adaptacion automatica
        screenWidth = (screenWidth - 12 * 4) / 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: screenWidth, height: screenWidth)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomEmailColletion = EmailCollectionData.dequeueReusableCellWithReuseIdentifier("cellEmailColl", forIndexPath: indexPath) as! CustomEmailColletion
        cell.ImgEmail.image =  UIImage(named:"photo_perfil.png")
        cell.TituloEmail.text = "test"
        return cell
    }
    
}
