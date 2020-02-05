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
    lazy var memeLibrary: [Meme] = [
        Meme(category: .food, imageData: convertToImageData(for: "avocado")),
        Meme(category: .sports, imageData: convertToImageData(for: "endofdecade")),
        Meme(category: .personal, imageData: convertToImageData(for: "summerSchool"))
    ]
    var memeLibraryURL: URL?{
    let fileManager = FileManager.default
    guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let listURL = documentsDir.appendingPathComponent(staticValues.memeLibraryPersistenceFileName)
    return listURL
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
        print(index)
        print(memeLibrary.count)
        memeLibrary.remove(at: index)
        print(memeLibrary.count)
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
        guard let imageData = meme.imageData else {return}
        pasteBoard.image = UIImage(data: imageData)
        
    }

    func convertToImageData(for image: String) -> Data?{
         guard let image = UIImage(named: image) else {return nil}
         let pngData = image.pngData()
        return pngData
     }
}
