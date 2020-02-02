//
//  LibraryViewController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
     //  MARK - Properties
        
        let searchController = UISearchController(searchResultsController: nil)
        var filterMemes: [Memes] = [] // need to change type to match model
        var isSearchEmoty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }
        
        
        
        // MARK - View Lifecycle

        override func viewDidLoad() {
            super.viewDidLoad()
            
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search Meme Categories"
            navigationItem.searchController = searchController
            definesPresentationContext = true
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

    // MARK - Extensions

    extension SearchController: UITableViewDelegate{
        
    }

    extension SearchController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            <#code#>
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            <#code#>
        }

        extension SearchController: UISearchResultsUpdating{
            func updateSearchResults(for searchController: UISearchResultsUpdating){
                let searchBar = searchController.searchBar
                filterContentForSearchText(searchBar.text)
            }
            
            // need to change parameter type to match model
            func filterContentForSearchText(_ searchText: String, category: Meme.Category? = nil){
                filteredMemes = memes.filter { (candy: Meme) -> Bool in return meme.name.lowercased().contains(search.lowercased())
                
            }
                tableView.reloadData()
            }
        }
        

}
