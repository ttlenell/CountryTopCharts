//
//  CountryTopChartsTests.swift
//  CountryTopChartsTests
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import XCTest
@testable import CountryTopCharts

class CountryTopChartsTests: XCTestCase {

    func testSortingAlgorithm() {
        let sortingUtility = SortingUtility()
        
        var array = [ArticleResponse(title: "t"),
                    ArticleResponse(title: "b"),
                    ArticleResponse(title: "c"),
                    ArticleResponse(title: "d"),
                    ArticleResponse(title: "e"),
                    ArticleResponse(title: "f"),
                    ArticleResponse(title: "g"),
                    ArticleResponse(title: "s"),
                    ArticleResponse(title: "i"),
                    ArticleResponse(title: "j"),
                    ArticleResponse(title: "k"),
                    ArticleResponse(title: "a")]
        
        let sortedArray = sortingUtility.bubbleSortNewsFeedAscending(newsFeed: array)
        
        XCTAssertLessThan(sortedArray.first!, sortedArray.last!)
    }
    
    func testEncryption() {
        
    }
    
    func testCountriesApiCallSpeed() {
        
    }

    func testSourcesApiCallSpeed() {
        
    }

}
