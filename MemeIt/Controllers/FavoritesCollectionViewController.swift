//
//  FavoritesCollectionViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController, ViewControllerMemeController {
    
    
    var memeController: MemeController?
    
    let imageNames = ["michael", "michael-scott"]
    var images: [UIImage] = []
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let memeController = memeController {
            return memeController.favoriteMemes.count
        }
        
        return 0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as? MemeCollectionViewCell else { return UICollectionViewCell() }
        
        if let image = memeController?.favoriteMemes[indexPath.item].image {
            cell.memeImageView.image = image
        }
        
        
        return cell
    }
    
    
    
    
    
}

extension FavoritesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.frame.width - 8
        let cellWidth = viewWidth / 3 - 2
        let size = CGSize(width: cellWidth, height: cellWidth - 2)
        return size
        
    }
    
}
