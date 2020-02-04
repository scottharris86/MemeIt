//
//  MemeController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/3/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit

struct staticValues {
    // Keys
    static var memeLibraryPersistenceFileName: String = "MemeLibrary.plist"
    
    // Cell names
    static var alertSearchCellName: String = "AlertSearchCell"
}


class MemeController {
    
    // MARK - Properties
    
    var memeLibrary: [Meme] = []
    var memeLibraryURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let listURL = documentsDir.appendingPathComponent(staticValues.memeLibraryPersistenceFileName)
        
        return listURL
    }
    
    var favoriteMemes: [Meme] {
        return memeLibrary.filter { $0.isFavorite }
    }
    
    init() {
        loadFromPersistnetStore()
    }
    
    // MARK - CRUD
    
    // create
    
    func createMeme(meme: Meme){
        let newMeme = meme
        memeLibrary.append(newMeme)
        saveToPersistentStore()
    }
    
    // update
    
    func addToFavorites(meme: Meme){
        meme.isFavorite = !meme.isFavorite
        saveToPersistentStore()
    }
    
    // delete
    
    func delete(meme: Meme){
        guard let index = memeLibrary.firstIndex(of: meme) else {return}
        memeLibrary.remove(at: index)
        saveToPersistentStore()
        
    }
    
    // Persistence
    
    func saveToPersistentStore(){
        
        guard let memeLibraryURL = memeLibraryURL else { return }
        
        let encoder = PropertyListEncoder()
        do{
            let listData = try encoder.encode(memeLibrary)
            try listData.write(to: memeLibraryURL)
        } catch {
            print("Error encoding books array: \(error)")
        }
    }
    
    func loadFromPersistnetStore (){
        
        guard let memeLibraryURL = memeLibraryURL else { return }
        
        do{
            let decoder = PropertyListDecoder()
            let memeLibraryData = try Data(contentsOf: memeLibraryURL)
            let memeLibraryArray = try decoder.decode([Meme].self, from: memeLibraryData)
            memeLibrary = memeLibraryArray
        } catch{
            print("Error decoding readList: \(error)")
        }
    }
    
    // Methods
    
    func addToClipboard (meme: Meme){
        let pasteBoard = UIPasteboard.general
        pasteBoard.image = UIImage(data: meme.imageData)
        
        let aLocalStringValue = "Local only string key"
        let aLocalStringKey = "Local only string value"
        
        pasteBoard.setItems([[aLocalStringKey: aLocalStringValue]], options: [UIPasteboard.OptionsKey.localOnly: true])
        
        let aExpiringStringKey = "Local only string key"
        let aExpiringStringValue = "Local only string value"
        
        let expirationDateOfTomorrow = Date().addingTimeInterval(60*60*24)
        
        pasteBoard.setItems([[aExpiringStringKey: aExpiringStringValue]], options: [UIPasteboard.OptionsKey.expirationDate: expirationDateOfTomorrow])
        
    }
}
