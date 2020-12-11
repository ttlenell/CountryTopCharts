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
    
    let selectedCountryPresenter = SelectedCountryPresenter()

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var topChartsClickableView: UIView!
    //@IBOutlet var topChartsClickableViewTapRegognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let country = selectedCountryPresenter.country else { return }
        
        countryNameLabel.text = country.name
        
        // Flag style rules
        self.countryFlagImageView.sd_setImage(with: URL(string: country.flag!), completed: nil)
        countryFlagImageView.layer.borderColor = UIColor.black.cgColor
        countryFlagImageView.layer.borderWidth = 0.5
        
        // topChartsClickableView rules
        let topChartsClickableViewTapRegognizer = UITapGestureRecognizer(target: self, action: #selector(topChartsClickableViewClicked))
        topChartsClickableViewTapRegognizer.numberOfTapsRequired = 1
        topChartsClickableViewTapRegognizer.numberOfTouchesRequired = 1
        topChartsClickableView.isUserInteractionEnabled = true
        topChartsClickableView.addGestureRecognizer(topChartsClickableViewTapRegognizer)
        
        
    }
    
    @objc func topChartsClickableViewClicked() {
        print("topcharts clicked")
    }
}
