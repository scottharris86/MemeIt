//
//  LibraryCollectionViewController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class LibraryCollectionViewController: BaseCollectionViewController, ViewControllerMemeController {
    
    //  MARK: - Properties
    
    let blackView = UIView()
    let slider = UIView()
    let alertTableView = UITableView()
    var searchOptionArray: [String] {
        return ["Save to clipboard", isAFavorite(indexPath: lastSelectedMemeCell), "Delete"]
    }
    var filterMemes: [Meme]  {
        filteredMemes()
    }
    var lastSelectedMemeCell: IndexPath = IndexPath(item: 0, section: 0)
    var memeController: MemeController?
    
    // MARK: - Outlets and Actions
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    @IBAction func IndexChanged(_ sender: UISegmentedControl) {
        
        collectionView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func filteredMemes () -> [Meme] {
        
        var searchFilteredMemes: [Meme] = []
        if let memeController = memeController{
            
            searchFilteredMemes = memeController.memeLibrary
            
            switch SegmentedControl.selectedSegmentIndex {
            case 0:
                break
            case 1:
                searchFilteredMemes = searchFilteredMemes.filter({
                    $0.category == .Food
                })
            case 2:
                searchFilteredMemes = searchFilteredMemes.filter({ $0.category == .Movie })
            case 3:
                searchFilteredMemes = searchFilteredMemes.filter({ $0.category == .Work })
            case 4:
                searchFilteredMemes = searchFilteredMemes.filter({ $0.category == .Sports })
            case 5:
                searchFilteredMemes = searchFilteredMemes.filter({ $0.category == .Personal })
            case 6:
                searchFilteredMemes = searchFilteredMemes.filter({ $0.category == .Uncategorized })
            default:
                break
            }
        }
        return searchFilteredMemes
        
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastSelectedMemeCell = indexPath
        let meme =  filterMemes[indexPath.item]
        alertShowSettings(meme: meme)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filterMemes.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCell", for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        
        let imageData = filterMemes[indexPath.row].imageData
        cell.LibraryImageView.image = UIImage(data: imageData)
        
        return cell
    }
    
    // MARK: - Methods
    
    func alertShowSettings(meme: Meme){
        if let window = (UIApplication.shared.windows.first { $0.isKeyWindow }) {
            let height = CGFloat(150) + window.safeAreaInsets.bottom
            let y = window.frame.height - height
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapTransparentView))
            // Black View Set Up
            window.addSubview(blackView)
            blackView.addGestureRecognizer(tapGesture)
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            //Slider Set Up
            window.addSubview(slider)
            slider.backgroundColor = .white
            slider.layer.cornerRadius = 8
            slider.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            // Table View Set Up
            alertTableView.frame =   CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            window.addSubview(alertTableView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.slider.frame = CGRect(x: 0, y: y, width: self.slider.frame.width, height: self.slider.frame.height)
                self.alertTableView.frame = CGRect(x: 0, y: y, width: self.alertTableView.frame.width, height: self.alertTableView.frame.height)
            }, completion: nil)
            
        }
        alertTableView.delegate = self
        alertTableView.dataSource = self
        alertTableView.register(AlertSearchTableViewCell.self, forCellReuseIdentifier: staticValues.alertSearchCellName)
        alertTableView.isScrollEnabled = false
        alertTableView.reloadData()
    }
    
    @objc func onTapTransparentView(){
        if let window = (UIApplication.shared.windows.first { $0.isKeyWindow }) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0
                if let window = (UIApplication.shared.windows.first { $0.isKeyWindow }) {
                    self.slider.frame = CGRect(x: 0, y: window.frame.height, width: self.slider.frame.width, height: self.slider.frame.height)
                }
                self.alertTableView.frame = CGRect(x: 0, y: window.frame.height, width: self.slider.frame.width, height: self.slider.frame.height)
            }, completion: nil)
        }
    }
    
    func deleteAlert(meme: Meme){
        let deleteAlert = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete the meme?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) {
            (deleteAction) in
            self.memeController?.delete(meme: meme)
            self.collectionView.deleteItems(at: [self.lastSelectedMemeCell])
        }
        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(deleteAction)
        present(deleteAlert, animated: true, completion: nil)
    }
    
    func isAFavorite (indexPath: IndexPath) -> String{
        
        let meme = filterMemes[lastSelectedMemeCell.row]
        if meme.isFavorite{
            return "Remove from favorites"
        } else{
            return "Add to favorites"
        }
        
    }
}


// MARK: - UITabelViewDelegate / UITableViewDataSource

extension LibraryCollectionViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Search Table View Set Up
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: staticValues.alertSearchCellName, for: indexPath) as? AlertSearchTableViewCell else {return UITableViewCell()}
        cell.alertLabel.text = searchOptionArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let memeController = memeController else {return}
        let meme = memeController.memeLibrary[lastSelectedMemeCell.row]
        switch indexPath.row {
        case 0:
            memeController.addToClipboard(meme: meme)
        case 1:
            memeController.addToFavorites(meme: meme)
        case 2:
            deleteAlert(meme: meme)
        default:
            break
        }
        tableView.reloadData()
        collectionView.reloadData()
        self.onTapTransparentView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
