//
//  ApiService.swift
//  MemeIt
//
//  Created by scott harris on 2/5/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation


class ApiService {
    // NETWORK REQUEST EXAMPLE
    // "https://api.giphy.com/v1/gifs/search?api_key=XeYLtK3j64US8ww7nt9ZfSwdNmwyMil4&limit=100&offset=0&rating=PG-13&lang=en&q="
    
    let baseURL = URL(string: "https://api.giphy.com/v1/gifs")!
    let apiKey = "XeYLtK3j64US8ww7nt9ZfSwdNmwyMil4"
    var limit = 25
    var offset = 0
    var rating = "PG-13"
    var language = "en"
    
    func fetchMemes(for keyword: String, completion: @escaping (Result<[Meme], NetworkError>) -> Void) {
        let searchURL = baseURL.appendingPathComponent("search")
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        let limitQueryItem = URLQueryItem(name: "limit", value: String(limit))
        let offsetQueryItem = URLQueryItem(name: "offset", value: String(offset))
        let languageQueryItem = URLQueryItem(name: "lang", value: language)
        let ratingQueryItem = URLQueryItem(name: "rating", value: rating)
        let searchQueryItem = URLQueryItem(name: "q", value: keyword)
        
        urlComponents?.queryItems = [apiKeyQueryItem, limitQueryItem, offsetQueryItem, ratingQueryItem, ratingQueryItem, languageQueryItem, searchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error returned from data task: \(error)")
                completion(.failure(.networkError))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let memes = try jsonDecoder.decode([Meme].self, from: data)
                completion(.success(memes))
            } catch {
                NSLog("Error decoding Memes: \(error)")
                completion(.failure(.noDecode))
                return
            }
            
        }.resume()
        
    }
    
    
}
