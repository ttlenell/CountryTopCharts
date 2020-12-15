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
    var countries: [CountryResponse]? = CountriesData.countries
    

    let newsAPI = NewsAPI()
    var sources: [Source]? = NewsData.sources
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(runGetCountries), name: Notification.Name("SourcesUpdated"), object: nil)
    }
    
    @objc func runGetCountries() {
        getCountries()
    }
    
    func getAcceptedCountries() {
        // Run get sources to trigger observer that will update countries
        getSources()
    }
    
    func getCountries() {
        print("running countries API (everything)")
        countriesAPI.getCountries()
    }
    
    func getNews() {
        print("running news API for just news")
        
        newsAPI.getNews()
    }
    
    func getSources() {
        print("running news API for sources (everything)")
        
        newsAPI.getSources()
    }
    
    func updateCountries() {
        var acceptedCountries: [CountryResponse] = []
    
        for country in CountriesData.countries! {
            for source in NewsData.sources!{
                if country.alpha2Code?.lowercased() == source.country?.lowercased() {
                    var countryExist = false
                    for acceptedCountry in acceptedCountries {
                        if acceptedCountry.alpha2Code ==  country.alpha2Code{
                            countryExist = true
                        }
                    }
                    if !countryExist {
                        acceptedCountries.append(country)
                    }
                    
                }
            }
        }
        
        CountriesData.countries = acceptedCountries
        self.countries = acceptedCountries
      
    }
}
