//
//  Meme.swift
//  MemeIt
//
//  Created by scott harris on 2/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit


struct Meme {
    var name: String
    var imageData: Data
    
    var image: UIImage? {
        let theImage = UIImage(data: imageData)
        return theImage
    }
    
}
