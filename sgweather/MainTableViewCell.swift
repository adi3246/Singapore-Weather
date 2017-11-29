//
//  MainTableViewCell.swift
//  sgweather
//
//  Created by Isa Andi on 28/11/2017.
//  Copyright © 2017 Massive Infinity. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet var lblForecastDate: UILabel!
    @IBOutlet var lblForecastTemp: UILabel!
    @IBOutlet var lblForecastText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
