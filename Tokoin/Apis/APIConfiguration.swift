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

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIRouter: URLRequestConvertible {
    
    case login(email:String, password:String)
    case posts
    case post(id: Int)
    case fetchNews(type: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .posts, .post, .fetchNews:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .posts:
            return "/posts"
        case .post(let id):
            return "/posts/\(id)"
        case .fetchNews(_):
            return "everything?q=bitcoin&from=2020-01-17&sortBy=publishedAt&apiKey=094158bde6d640f3890cc4ac22d478d5"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
        case .fetchNews(let type):
            return [K.APIParameterKey.query: type]
        case .posts, .post:
            return nil
        }
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


