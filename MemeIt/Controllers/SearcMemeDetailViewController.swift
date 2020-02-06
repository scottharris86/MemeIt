//
//  SearcMemeDetailViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/6/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class SearcMemeDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "Meme_title"))
        
        
        
        navigationItem.titleView = imageView

    }
    
}
