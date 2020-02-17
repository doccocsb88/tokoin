//
//  ArticleResponse.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
