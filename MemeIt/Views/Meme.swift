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
    case uncategorized = "Not Categorized"
}

struct Meme: Codable{
    
    var category: MemeCategory
    var imageData: Data
    var isFavorite: Bool
}

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
        
        self = MemeCategory(rawValue: rawValue) ?? .uncategorized
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(rawValue, forKey: .rawValue)
    }
    
    
}
