//
//  BaseNavigationController.swift
//  MemeIt
//
//  Created by scott harris on 2/6/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 0 / 255, green: 87 / 255, blue: 231 / 255, alpha: 1)
    
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        
        navigationBar.tintColor = .white
        navigationBar.overrideUserInterfaceStyle = .dark
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
        
        
        let imageView = UIImageView(image: UIImage(named: "Meme_title"))
        
    
        
        navigationItem.titleView = imageView
//        imageView.frame = navigationItem.titleView?.frame
                
    }

}
