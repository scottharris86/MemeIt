//
//  BaseCollectionViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/6/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemGray6
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension BaseCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.frame.width - 8
        let cellWidth = viewWidth / 3 - 2
        let size = CGSize(width: cellWidth, height: cellWidth - 2)
        return size
        
    }
    
}
