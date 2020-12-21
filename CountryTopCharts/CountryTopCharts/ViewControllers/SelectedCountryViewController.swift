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
    @IBOutlet weak var newsClickableView: UIImageView!
    //@IBOutlet var topChartsClickableViewTapRegognizer: UITapGestureRecognizer!
    @IBOutlet weak var newsClickableViewTitleLabel: UILabel!

    
    @IBOutlet weak var newsClickableImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let country = selectedCountryPresenter.country else { return }
        
        countryNameLabel.text = country.name
        countryNameLabel.numberOfLines = 4
        
        // Flag style rules
        self.countryFlagImageView.sd_setImage(with: URL(string: country.flag!), placeholderImage: UIImage(named: "imagenotfound.jpg"), completed: nil)
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
        performSegue(withIdentifier: "segueToNewsFeed", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        selectedCountryPresenter.clearNewsFeedCache()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToNewsFeed" {
            
            let destinationVC = segue.destination as? NewsFeedViewController
            
            let country = selectedCountryPresenter.country
            
            destinationVC?.newsPresenter.countryCode = country?.alpha2Code
            
        }
    }
}
