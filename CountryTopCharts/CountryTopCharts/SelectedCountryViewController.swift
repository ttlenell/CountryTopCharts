//
//  ViewController.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-09.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class SelectedCountryViewController: UIViewController {
    
    var countryIndex = 0
    
    let countriesPresenter = CountriesPresenter()
    
    var country: Country?

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let countries = countriesPresenter.countries else { return }
        
        country = countries[countryIndex]
        
        guard let country = country else { return }
        
        countryNameLabel.text = country.name
        
    }
    

    

}
