//
//  CountryTableViewCell.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-03.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet var countryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
