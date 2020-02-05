//
//  LibraryViewController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {
    
    //  MARK - Properties
<<<<<<< HEAD
    
=======
    var memes: [Meme]?
>>>>>>> master
    let blackView = UIView()
    let slider = UIView()
    let alertTableView = UITableView()
    let searchOptionArray = ["Save to clipboard", "Add to favorites", "Delete"]
    let memeController = MemeController()
    lazy var filterMemes = memeController.memeLibrary
    var lastSelectedMemeCell: IndexPath = IndexPath(item: 0, section: 0)
    
    // MARK - Outlets and Actions
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    @IBAction func IndexChanged(_ sender: UISegmentedControl) {
        switch SegmentedControl.selectedSegmentIndex {
        case 0:
            filterMemes = memeController.memeLibrary
        case 1:
            filterMemes = memeController.memeLibrary.filter({ $0.category == .food })
        case 2:
            filterMemes = memeController.memeLibrary.filter({ $0.category == .movie })
        case 3:
            filterMemes = memeController.memeLibrary.filter({ $0.category == .personal })
        case 4:
            filterMemes = memeController.memeLibrary.filter({ $0.category == .sports })
        case 5:
            filterMemes = memeController.memeLibrary.filter({ $0.category == .work })
        case 6:
            filterMemes = memeController.memeLibrary.filter({ $0.category == .uncategorized })
        default:
            filterMemes = memeController.memeLibrary
        }
        collectionView.reloadData()
    }
    
    // MARK - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterMemes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        guard let imageData = filterMemes[indexPath.row].imageData else {return UICollectionViewCell()}
        cell.searchImageView.image = UIImage(data: imageData)
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        lastSelectedMemeCell = indexPath
        let meme =  memeController.memeLibrary[indexPath.item]
        alertShowSettings(meme: meme)
    }
    
    // MARK - Methods
    
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
    
<<<<<<< HEAD
    func deleteAlert(meme: Meme){
        let deleteAlert = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete the meme?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) {
            (deleteAction) in
            self.memeController.delete(meme: meme)
            
            self.collectionView.deleteItems(at: [self.lastSelectedMemeCell])
=======
}


//  MARK - Extensions

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let category = MemeCategory(rawValue:
            searchBar.scopeButtonTitles![selectedScope]) else {return}
        filterContentForSearchText(searchBar.text!, category: category)
    }
}

extension SearchCollectionViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text else {return}
        filterContentForSearchText(searchText, category: MemeCategory(rawValue: searchText.description)!)
    }
    
    func filterContentForSearchText(_ searchText: String, category: MemeCategory){
        if let memes = memes {
            var filteredMemes = memes.filter {
                $0.category.rawValue.lowercased().contains(searchText.lowercased())
            }
>>>>>>> master
        }
        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(deleteAction)
        present(deleteAlert, animated: true, completion: nil)
    }
}

//  MARK - Extensions

extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.frame.width - 8
        let cellWidth = viewWidth / 3 - 2
        print(cellWidth)
        let size = CGSize(width: cellWidth, height: cellWidth - 2)
        return size
    }
}

extension SearchCollectionViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Search Table View Set Up
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: staticValues.alertSearchCellName, for: indexPath) as? AlertSearchTableViewCell else {return UITableViewCell()}
        cell.alertLabel.text = searchOptionArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        self.onTapTransparentView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
