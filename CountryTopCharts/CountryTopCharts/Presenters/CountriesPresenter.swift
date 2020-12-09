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
    
    // metoder för att använda APIs
    
    func getCountries() {
        print("running")
        countriesAPI.getCountries()
    }
    
    func updateCountries() {
        self.countries = CountriesData.countries
    }
}
