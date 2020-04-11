//
//  SearchMemesCollectionViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/5/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit


class SearchMemesCollectionViewController: BaseCollectionViewController, ViewControllerMemeController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var memeController: MemeController?
    
    let apiService = ApiService()
    
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
        
        var meme = memes[indexPath.item]
        guard let memeImage = meme.images else { return cell }
            self.apiService.fetchImage(at: memeImage.fixed_width_still.url) { result in
                if let image = try? result.get() {
                    meme.imageData = image.pngData()
                    self.memes.replaceSubrange(indexPath.item...indexPath.item, with: [meme])
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                    
                }
            }
        
        return cell
        
    }
    
    func fetchMemes(_ searchText: String) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        
        let backView = UIView()
        backView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(backView)
        view.bringSubviewToFront(backView)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        backView.addSubview(spinner)
        
        
        backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        backView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        apiService.fetchMemes(for: searchText) { result in
            do {
                let memes = try result.get()
                DispatchQueue.main.async {
                    self.memes = memes
                    self.collectionView.reloadData()
                    self.searchController.searchBar.text = ""
                    backView.removeFromSuperview()
                    spinner.stopAnimating()
                }
                
            } catch {
                if let error = error as? NetworkError {
                    switch error {
                        case .badAuth:
                            NSLog("Missing or bad API Key")
                        case .networkError:
                            NSLog("Network error recieved")
                        case .badData:
                            NSLog("Invalid data response")
                        case .noDecode:
                            NSLog("Error decoding memes")
                        case .badUrl:
                            NSLog("Bad URL")
                        case .badImage:
                            NSLog("Bad Image")
                    }
                    DispatchQueue.main.async {
                        self.searchController.searchBar.text = ""
                        backView.removeFromSuperview()
                        spinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetailShowSegue" {
            if let detailVC = segue.destination as? CreateMemeDetailViewController {
                if let index = collectionView.indexPathsForSelectedItems?.first {
                    let meme = memes[index.item]
                    detailVC.meme = meme
                    if let memeController = memeController {
                        detailVC.memeController = memeController
                    }
                    
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
