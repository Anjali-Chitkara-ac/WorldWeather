//
//  CityWeatherTableViewCell.swift
//  WorldWeather
//
//  Created by Anjali Chitkara on 10/29/21.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCityName: UILabel!
    
    @IBOutlet weak var lblWeatherTxt: UILabel!
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var lblTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
