//
//  MemeModel.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit



class Meme: Codable {
    
    var category: MemeCategory
    var imageData: Data
    var isFavorite: Bool
    var image: UIImage? {
        return UIImage(data: imageData)
    }
    
    init(category: MemeCategory, imageData: Data, isFavorite: Bool = false){
        self.category = category
        self.imageData = imageData
        self.isFavorite = isFavorite
    }
}
