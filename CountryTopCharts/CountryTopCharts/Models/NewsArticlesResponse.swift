//
//  NewsArticles.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

struct ArticlesResponse: Codable {
    // all the articles from selected country
    var articles: [ArticleResponse]?
    
  
}

struct ArticleResponse: Codable {
    // specific article
    var author: String?
    var title: String?
    var description: String?
    var content: String?
    var publishedAt: String?
    var url: String?
    var urlToImage: String?
    var source: ArticleSourceResponse?
    
}

struct ArticleSourceResponse: Codable {
    var id: String?
    var name: String?
}
