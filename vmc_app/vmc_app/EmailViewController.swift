//
//  EmailViewController.swift
//  vmc_app
//
//  Created by macbook3 on 12/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
class EmailViewController: UICollectionViewController {
    
    var datosColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datosColeccion.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell_colletion", forIndexPath: indexPath) as UICollectionViewCell
        
        return cell
    }
}
