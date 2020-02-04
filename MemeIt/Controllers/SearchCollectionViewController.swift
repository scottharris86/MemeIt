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
    
    var memes: [Meme]?
    let blackView = UIView()
    let slider = UIView()
    let alertTableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    let searchOptionArray = ["Save to clipboard", "Add to favorites", "Delete"]
    var filterMemes: [Meme] = []
    let memeController = MemeController()
    
    var isSearchEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    // MARK - View Lifecycle
    
    let imageNames = ["michael", "michael-scott"]
    var images: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meme Categories"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for _ in 0...19 {
            let random = Int.random(in: 0...1)
            let image = imageNames[random]
            images.append(UIImage(named: image)!)
            
        }
    }
    
    
    // MARK - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        //        cell.searchImageView.image = UIImage(data: filterMemes[indexPath.row].imageData)
        cell.searchImageView.image = images[indexPath.item]
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let meme =  memeLibraryController.memeLibrary[indexPath.item]
        let meme = Meme(category: .uncategorized, imageData: UIImage(named: "michael")!.pngData()!)
        alertShowSettings(meme: meme)
        //        collectionView.reloadItems(at: [indexPath])
        
    }
    
    // MARK - Methods
    
    func alertShowSettings(meme: Meme){
        
        // show menu
        if let window = (UIApplication.shared.windows.first { $0.isKeyWindow }) {
            
            let height = CGFloat(150) + window.safeAreaInsets.bottom
            let y = window.frame.height - height
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapTransparentView))
            
            window.addSubview(blackView)
            blackView.addGestureRecognizer(tapGesture)
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            //            blackView.alpha = 0
            
            window.addSubview(slider)
            slider.backgroundColor = .white
            slider.layer.cornerRadius = 8
            slider.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            // Table view set up
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
    
}


//  MARK - Extensions

extension SearchCollectionViewController: UISearchBarDelegate{
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
        }
        
    }
}

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
        
        let image = images[indexPath.row]
        
        let meme = Meme(category: .uncategorized, imageData: image.pngData()!)
        //        guard let meme = memes[indexPath.row] else {return}
        
        switch indexPath.row {
        case 0:
            memeController.addToClipboard(meme: meme)
        case 1:
            memeController.addToFavorites(meme: meme)
        case 2:
            memeController.delete(meme: meme)
        default:
            break
        }
        self.onTapTransparentView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

