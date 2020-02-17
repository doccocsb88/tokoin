//
//  Constants.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import Alamofire

struct Constants {
    
    //The API's base URL
    static let baseUrl = "http://newsapi.org/v2/"
    
    //The parameters (Queries) that we're gonna use
    struct Parameters {
        static let userId = "q"
        static let APIKey = "094158bde6d640f3890cc4ac22d478d5"
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}

