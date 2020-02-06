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
        var memes: [Meme] = []
        let search = keyword
        
        if let safe = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
           let full = "\(baseUrl)\(safe)"
        

            if let url = URL(string: full) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error getting data: \(error.localizedDescription)")
                        return
                    }
                    
                    do {
                        if let data = data,
                            let jsonDictionaries = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                            
                            if let objects = jsonDictionaries["data"] as? [[String: AnyObject]] {
                                for obj in objects {
                                    if let title = obj["title"] as? String,
                                        let id = obj["id"] as? String {
                                        if let images = obj["images"] as? [String: AnyObject] {
                                            if let whatIWant = images["original_still"] as? [String: String] {
                                                if let imageURL = whatIWant["url"],
                                                    let url = URL(string: imageURL) {
                                                    
                                                    do {
                                                        let data = try Data(contentsOf: url)
                                                        let meme = Meme(category: .Uncategorized, imageData: data)
                                                        memes.append(meme)
                                                        

                                                        let str = "erfwefewf"
                                                    } catch {
                                                        print(error)
                                                    }
                                                    
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                DispatchQueue.main.async {
                                    completion(memes)
                                }

                            }
                            
                        }
                        
                        
                        
                    } catch {
                        print(error)
                    }
                    
                    
                   
                    
                    }.resume()
                 
            }
        }
        
    }

    
}
