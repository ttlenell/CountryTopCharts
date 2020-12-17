//
//  News.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-15.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation



struct SourcesResponse: Codable {
    // everything from newsAPI.org sources endpoint
    var sources: [Source]?

}

struct Source: Codable {
    // country code (2 letters) from newsAPI.org source.country
    var country: String?
}



