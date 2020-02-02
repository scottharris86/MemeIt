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

struct Meme{
    
    var category: MemeCategory
    var image: UIImage
    
}
