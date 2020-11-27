//
//  Presenter.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class Presenter {
    
    let countyCode: String = ""
    let countriesAPI = CountriesAPI()
    
    
    
    // metoder för att använda APIs
    
    func logResponse() {
        countriesAPI.getCountries()
    }
    
}
