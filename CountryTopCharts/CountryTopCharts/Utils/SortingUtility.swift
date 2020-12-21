//
//  SortingUtility.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-20.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class SortingUtility {
    
    class func bubbleSortNewsFeedAscending (newsFeed: [ArticleResponse]) -> [ArticleResponse]  {
        
        var array = newsFeed
        for _ in 0...(array.count - 1) {
            for j in 1...(array.count - 1) {
                if array[j] < array[j-1] {
                  let tmp = array[j-1]
                  array[j-1] = array[j]
                  array[j] = tmp
            }
          }
        }
        return array
    }
    
}
