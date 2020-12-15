//
//  News.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-15.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation



struct News: Codable {

    var sources: [Source]?

}

struct Source: Codable {
    var country: String?
}

