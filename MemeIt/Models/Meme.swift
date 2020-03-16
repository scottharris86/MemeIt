//
//  MemeModel.swift
//  MemeIt
//
//  Created by Chris Gonzales on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit


struct Meme: Codable {
    let id: String?
    var category: MemeCategory?
    var imageData: Data? {
        didSet {
            updateImage()
        }
    }
    var isFavorite: Bool?
    var image: UIImage?
    let images: MemeImageObject?
    
    enum CodingKeys: String, CodingKey {
        case id
        case images
        case isFavorite
        case imageData
        case category
        
    }
    
    private mutating func updateImage() {
        if let imageData = imageData {
            self.image = UIImage(data: imageData)
        }
    }
    
}

struct MemeData: Codable {
    let data: [Meme]
}

struct MemeImages: Codable {
    let images: MemeImageObject
}

struct MemeImageObject: Codable {
    let fixed_width_still: MemeImageUrl
    
    enum CodingKeys: String, CodingKey {
        case fixed_width_still = "original_still"
    }
}

struct MemeImageUrl: Codable {
    let url: String
}
