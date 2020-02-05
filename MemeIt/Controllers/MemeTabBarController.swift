//
//  MemeTabBarController.swift
//  MemeIt
//
//  Created by scott harris on 2/4/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class MemeTabBarController: UITabBarController {
    
    let memeController = MemeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
        
    }
    
    func setupChildViewControllers() {
        for navController in children {
            if let vc = navController as? UINavigationController {
                if let viewController = vc.topViewController as? ViewControllerMemeController {
                    viewController.memeController = memeController
                }
            }
        }
    }
    
}
