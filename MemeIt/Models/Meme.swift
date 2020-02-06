//
//  MemeModel.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit

enum MemeCategory: String, CaseIterable{
    case Uncategorized = "Uncategorized"
    case Food = "Food"
    case Movie = "Movie"
    case Sports = "Sports"
    case Work = "Work"
    case Personal = "Personal"
    
//    static var memeCategoryCount: Int{
//        return MemeCategory.Personal.hashValue + 1
//    }
}

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

// MARK - Extensions

extension MemeCategory: Codable {
    enum Key: CodingKey {
        case rawValue
    }
    enum CodingError: Error {
        case unknownValue
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        self = MemeCategory(rawValue: rawValue) ?? .Uncategorized
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(rawValue, forKey: .rawValue)
    }
}

extension Meme: Equatable{
    static func == (lhs: Meme, rhs: Meme) -> Bool {
        if lhs.imageData == rhs.imageData{ return true} else {return false}
    }
}
