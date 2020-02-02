//
//  FavoritesCollectionViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController {
    
    let imageNames = ["michael", "michael-scott"]
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        for _ in 0...19 {
            let random = Int.random(in: 0...1)
            let image = imageNames[random]
            images.append(UIImage(named: image)!)
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as? MemeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.memeImageView.image = images[indexPath.item]
        
        return cell
    }
    
}
