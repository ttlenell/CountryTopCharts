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
    var news: News? = NewsData.news
    
    func getNews() {
        print("running news API for just news")
        
        newsAPI.getNews()
    }
    
    // funktion för att uppdatera med observer, likt updatecountries()?
    // func updateNews() {
    // }
}
