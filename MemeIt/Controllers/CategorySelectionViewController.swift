//
//  CategorySelectionViewController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/6/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class CategorySelectionViewController: UIViewController, ViewControllerMemeController {


    var meme: Meme?
    var memeController: MemeController?
    
    func resetViews() {
        tabBarController?.selectedIndex = 0
        if let createVc = navigationController?.viewControllers.first as? CreateMemeDetailViewController {
            createVc.meme = nil
            createVc.memeTextField.text = ""
            navigationController?.popViewController(animated: false)
        } else {
            if let createVc = navigationController?.viewControllers[1] as? CreateMemeDetailViewController {
                createVc.meme = nil
                createVc.memeTextField.text = ""
                navigationController?.popToRootViewController(animated: false)
            }
        }
        
    }

    
    @IBAction func foodSelected(_ sender: UIButton) {
        guard let unwrappedMeme = meme else {return}
        if let memeController = memeController {
            memeController.changeCategory(meme: unwrappedMeme, category: .Food)
            resetViews()
            
        }
        
    }
    @IBAction func moviesSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        if let memeController = memeController {
            memeController.changeCategory(meme: unwrappedMeme, category: .Movie)
            resetViews()
            
        }
        
    }
    @IBAction func sportsSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        if let memeController = memeController {
            memeController.changeCategory(meme: unwrappedMeme, category: .Sports)
            resetViews()
            
        }

    }
    @IBAction func workSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        if let memeController = memeController {
            memeController.changeCategory(meme: unwrappedMeme, category: .Work)
            resetViews()
            
        }
    }
    @IBAction func personalSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        if let memeController = memeController {
            memeController.changeCategory(meme: unwrappedMeme, category: .Personal)
            resetViews()
            
        }
    }
    
    @IBAction func noneSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        if let memeController = memeController {
            memeController.changeCategory(meme: unwrappedMeme, category: .Uncategorized)
            resetViews()
            
        }
    }
    
}
