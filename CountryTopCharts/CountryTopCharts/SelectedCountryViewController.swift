//
//  ViewController.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-09.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit
import SDWebImage

class SelectedCountryViewController: UIViewController {
    
    var countryIndex = 0
    
    let countriesPresenter = CountriesPresenter()
    
    var country: Country?

    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var countryFlagImageView: UIImageView!
    
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let countries = countriesPresenter.countries else { return }
        
        country = countries[countryIndex]
        
        guard let country = country else { return }
        
        countryNameLabel.text = country.name
        
        self.countryFlagImageView.sd_setImage(with: URL(string: country.flag!), completed: nil)
        
        
    }
    
//    func setFlagImage(country: Country) {
//        guard let url = URL(string: country.flag!) else { return }
//
//        let getDataTask = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                print(image)
//                self.countryFlagImageView.image = image
//            }
//        })
//
//        getDataTask.resume()
//    }
    

    

}
