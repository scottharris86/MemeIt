//
//  CategorySelectionViewController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/6/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class CategorySelectionViewController: UIViewController {


    var meme: Meme?{
        didSet{
            print("success")
        }
    }
    let memeController = MemeController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func foodSelected(_ sender: UIButton) {
        guard let unwrappedMeme = meme else {return}
        unwrappedMeme.category = .Food
        memeController.saveToPersistentStore()
        
    }
    @IBAction func moviesSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        unwrappedMeme.category = .Movie
        memeController.saveToPersistentStore()
        
    }
    @IBAction func sportsSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        unwrappedMeme.category = .Sports
        memeController.saveToPersistentStore()
    }
    @IBAction func workSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        unwrappedMeme.category = .Work
        memeController.saveToPersistentStore()
    }
    @IBAction func personalSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        unwrappedMeme.category = .Personal
        memeController.saveToPersistentStore()
    }
    @IBAction func noneSelected(_ sender: Any) {
        guard let unwrappedMeme = meme else {return}
        unwrappedMeme.category = .Uncategorized
        memeController.saveToPersistentStore()
    }
    

}
