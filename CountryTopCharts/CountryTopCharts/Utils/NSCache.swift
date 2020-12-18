//
//  NSCache.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-18.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class Cache {
    
    static let cache = NSCache<NSString, ArticleHolder>()
    
}
