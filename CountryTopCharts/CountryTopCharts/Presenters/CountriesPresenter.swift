//
//  Presenter.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class CountriesPresenter {
    
    let countriesAPI = CountriesAPI()
    var countries: [Country]? = CountriesData.countries
    

    let newsAPI = NewsAPI()
    var news: News? = NewsData.news
    
    // metoder för att använda APIs
    
    func getCountries() {
        print("running countries API")
        countriesAPI.getCountries()
    }
    
    func getNews() {
        print("running news API")
        
        newsAPI.getNews()
    }
    
    func updateCountries() {
        self.countries = CountriesData.countries
    }
}
