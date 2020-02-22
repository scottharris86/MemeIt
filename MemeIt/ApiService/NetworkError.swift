//
//  NetworkError.swift
//  MemeIt
//
//  Created by scott harris on 2/22/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case badAuth
    case badData
    case noDecode
    case badImage
    case badUrl
}
