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
    @IBOutlet weak var newsClickableView: UIView!
    //@IBOutlet var topChartsClickableViewTapRegognizer: UITapGestureRecognizer!
    @IBOutlet weak var newsClickableViewTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let country = selectedCountryPresenter.country else { return }
        
        countryNameLabel.text = country.name
        
        // Flag style rules
        self.countryFlagImageView.sd_setImage(with: URL(string: country.flag!), completed: nil)
        countryFlagImageView.layer.borderColor = UIColor.black.cgColor
        countryFlagImageView.layer.borderWidth = 0.5
        
        // newsClickableView rules
        let newsClickableViewTapRegognizer = UITapGestureRecognizer(target: self, action: #selector(newsClickableViewClicked))
        newsClickableViewTapRegognizer.numberOfTapsRequired = 1
        newsClickableViewTapRegognizer.numberOfTouchesRequired = 1
        newsClickableView.isUserInteractionEnabled = true
        newsClickableView.addGestureRecognizer(newsClickableViewTapRegognizer)
        
        newsClickableView.layer.borderColor = UIColor.black.cgColor
        newsClickableView.layer.borderWidth = 0.5
        
        
        
        
        
    }
    
    @objc func newsClickableViewClicked() {
        print("news clicked")
    }
}
