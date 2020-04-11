//
//  MemeCategory.swift
//  MemeIt
//
//  Created by scott harris on 2/22/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

enum MemeCategory: String, CaseIterable{
    case Uncategorized = "Uncategorized"
    case Food = "Food"
    case Movie = "Movie"
    case Sports = "Sports"
    case Work = "Work"
    case Personal = "Personal"

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
