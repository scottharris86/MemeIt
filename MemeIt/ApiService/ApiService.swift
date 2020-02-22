//
//  ApiService.swift
//  MemeIt
//
//  Created by scott harris on 2/5/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation



class ApiService {
    let baseUrl = "https://api.giphy.com/v1/gifs/search?api_key=XeYLtK3j64US8ww7nt9ZfSwdNmwyMil4&limit=100&offset=0&rating=PG-13&lang=en&q="
    
    static let sharedInstance = ApiService()
    
    func fetchKeyword(keyword: String) {
        
    }
    
    func fetchMemesForKeyword(keyword: String, completion: @escaping ([Meme]) -> ()) {
        
        
    }
    
    
}
