//
//  SearchMemesCollectionViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/5/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit


class SearchMemesCollectionViewController: BaseCollectionViewController {
    
    var memes: [Meme] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Memes"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        // 6
        searchController.searchBar.delegate = self
        
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.tintColor = .white
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBackground]
        searchController.searchBar.searchTextField.leftView?.tintColor = .systemGray

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let meme = memes[indexPath.item]
        cell.imageView.image = meme.image
        
        return cell
        
    }
    
    func fetchMemes(_ searchText: String) {
        ApiService.sharedInstance.fetchMemesForKeyword(keyword: searchText) { (memes: [Meme]) in
            self.memes = memes
            self.collectionView.reloadData()
            self.searchController.searchBar.text = ""
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetailShowSegue" {
            if let detailVC = segue.destination as? CreateMemeDetailViewController {
                if let index = collectionView.indexPathsForSelectedItems?.first {
                    let meme = memes[index.item]
                    detailVC.meme = meme
                }
            }
        }
    }
    
}

extension SearchMemesCollectionViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // implement!!!
       
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        fetchMemes(searchBar.text!)
    }
    
    
    
}
