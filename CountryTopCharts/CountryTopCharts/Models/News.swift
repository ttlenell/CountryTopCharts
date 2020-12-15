//
//  News.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-15.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation



struct News: Codable {
    // everything from newsAPI.org
    var sources: [Source]?

}

struct Source: Codable {
    // country code (2 letters) from newsAPI.org
    var country: String?
}

