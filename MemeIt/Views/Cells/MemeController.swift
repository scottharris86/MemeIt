//
//  MemeController.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/3/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit

struct staticValues{
     // Keys
    static var memeLibraryPersistenceFileName: String = "MemeLibrary.plist"
    
    
    // Custom Cell Identifiers
    
    
    // Segue Identifiers
    
    
}


class MemeLibrary{
    
    // MARK - Properties
    
    var memeLibraryURL: URL?{
    let fileManager = FileManager.default
    guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let listURL = documentsDir.appendingPathComponent(staticValues.memeLibraryPersistenceFileName)
        
    return listURL
    }
    
    // MARK - CRUD
    
    // create
    var memeLibrary = [Meme]()
        
    

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
       
//       func loadFromPersistnetStore (){
//
//           guard let memeLibraryURL = memeLibraryURL else { return }
//
//           do{
//               let decoder = PropertyListDecoder()
//            let memeLibraryData = try Data(contentsOf: memeLibraryURL)
//               let memeLibraryArray = try decoder.decode([Meme].self, from: memeLibraryData)
//           } catch{
//               print("Error decoding readList: \(error)")
//           }
//       }
}
