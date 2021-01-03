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
        
        let array = [ArticleResponse(title: "t"),
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
        
        let sortedArray = SortingUtility.bubbleSortNewsFeedAscending(newsFeed: array)
        
        XCTAssertLessThan(sortedArray.first!, sortedArray.last!)
    }
    
    func testEncryption() {
        
        
        let string = "Password123"
        
        guard let encodedString = EncyptionUtility.encodeString(stringToEncode: string) else { return }
        
        guard let decodedString = EncyptionUtility.decodeString(dataToDecode: encodedString) else { return }
        
        XCTAssertEqual(string, decodedString)
    }

}
