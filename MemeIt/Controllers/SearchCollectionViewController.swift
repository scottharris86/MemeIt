//
//  LibraryViewController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit


//need delegate to pass meme library, so the filter method can create a new array of memes based on the category

protocol memeLibraryDelegate {
    var memeLibrary: [Meme]{get}
}


class SearchCollectionViewController: UICollectionViewController {
    
    //  MARK - Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    var filterMemes: [Meme] = []
    var memeLibraryDelegate: memeLibraryDelegate?
    
    var isSearchEmoty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    // MARK - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meme Categories"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    // MARK - Table DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterMemes.count}
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.searchImageView.image = UIImage(data: filterMemes[indexPath.row].imageData)
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        var filteredMemes = memes.filter { (meme: memeLibraryDelegate) -> Bool in return
            meme.category.lowercased().contains(searchText.lowercased())
        }
    }
}


