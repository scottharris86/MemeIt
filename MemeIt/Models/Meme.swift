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
    case food = "Food Reference"
    case movie = "Movie Refernence"
    case sports = "Sport Reference"
    case work = "Work Reference"
    case personal = "Personal Reference"
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
        self = MemeCategory(rawValue: rawValue) ?? .uncategorized
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

extension Meme: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    func isEqual(_ object: Any?) -> Bool {
        <#code#>
    }
    
    var hash: Int {
        <#code#>
    }
    
    var superclass: AnyClass? {
        <#code#>
    }
    
    func `self`() -> Self {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func isProxy() -> Bool {
        <#code#>
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        <#code#>
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        <#code#>
    }
    
    var description: String {
        <#code#>
    }
    
    
}
