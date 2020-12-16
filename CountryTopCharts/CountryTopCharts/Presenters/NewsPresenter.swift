//
//  NewsPresenter.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-15.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class NewsPresenter {
    let newsAPI = NewsAPI()
    
    var countryCode: String?
    
    func getNews() {
        print("running news API for just news")
        
        newsAPI.getNews(countryCode: countryCode!)
    }
    
    // funktion för att uppdatera med observer, likt updatecountries()?
    // func updateNews() {
    // }
}
