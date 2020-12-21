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
        let sut = CountryListViewController()
        
        let string = "Password123"
        
        guard let encodedString = sut.encodeString(stringToEncode: string) else { return }
        
        guard let decodedString = sut.decodeString(dataToDecode: encodedString) else { return }
        
        XCTAssertEqual(string, decodedString)
    }
    
    func testCountriesApiCallSpeed() {
        
        let urlString: String = "https://restcountries.eu/rest/v2/all"
        
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let startDate = Date()
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        if (error != nil) {
            //error!
            
            
         } else {
            //inte error!
            
            do {
                let executionTime = Date().timeIntervalSince(startDate)
                print("countrieS exe time: ",  executionTime)
                XCTAssertLessThan(executionTime, 1)
            }
            
            }})
        task.resume()
    }

}
