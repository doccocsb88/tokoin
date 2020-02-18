//
//  APIConfiguration.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import Alamofire

struct K {
    static let APIKey = "094158bde6d640f3890cc4ac22d478d5"
    
    struct ProductionServer {
        static let baseURL = "http://newsapi.org/v2/"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let apiKey  = "apiKey"
        static let query = "q"
        static let country = "country"
        static let category = "category"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}

enum ResponseStatus: String {
    case ok = "ok"
    case error = "error"
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIRouter: URLRequestConvertible {
    
    case fetchNews(type: String, page: Int?, pageSize: Int?)
    case fetchHeadLine(country: String, category: String?, page: Int?, pageSize: Int?)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .fetchNews, .fetchHeadLine:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .fetchNews(let keyword, let page, let pageSize):
            var newsPath =  "everything?q=\(keyword)"
            if let page = page {
                newsPath.append("&page=\(page)")
            }
            if let pageSize = pageSize {
                newsPath.append("&pageSize=\(pageSize)")
            }
            newsPath.append("&apiKey=\(K.APIKey)")
            return newsPath
        case .fetchHeadLine(let country, let category, let page, let pageSize):
            var headLinePath = "top-headlines?country=\(country)"
            if let cat = category {
                headLinePath.append("&category=c")
            }
            if let page = page {
                headLinePath.append("&page=\(page)")
            }
            if let pageSize = pageSize {
                headLinePath.append("&pageSize=\(pageSize)")
            }
            headLinePath.append("&apiKey=\(K.APIKey)")
            return headLinePath
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        return nil
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
     
        //                     HTTP Method
        urlRequest.httpMethod = method.rawValue
                            
        //                     Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(K.APIKey, forHTTPHeaderField: "X-Api-Key")
        //                     Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody =  try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                
            }
        }
                 
        return urlRequest
    }
    
    
    func getAPIURL() -> String {
       return "\(K.ProductionServer.baseURL)\(path)"
    }
}



