//
//  EmailViewController.swift
//  vmc_app
//
//  Created by macbook3 on 12/8/16.
//  Copyright © 2016 HispanoSoluciones. All rights reserved.
//

import UIKit
class EmailViewController: UICollectionViewController {
    
    var tituloColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    var imgTituloColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    var thumbColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    var footerColeccion = ["elemnto 1","elemnto 2", "elemnto 3","elemnto 4","elemnto 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.thumbColeccion.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell_colletion", forIndexPath: indexPath) as UICollectionViewCell
        let thumbnail = cell.viewWithTag(2) as! UIImageView
        thumbnail.image = UIImage(named: "photo_perfil.png")
        let footer = cell.viewWithTag(3) as! UILabel
        print(footer)
        footer.text = self.footerColeccion[indexPath.row]
        
        return cell
    }
}
