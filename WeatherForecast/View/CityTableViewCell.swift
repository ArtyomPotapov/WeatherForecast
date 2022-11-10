//
//  CityTableViewCell.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    


    func setLabels(weather: Weather){
        self.cityNameLabel.text = weather.name
        self.statusLabel.text = weather.conditionString
        tempLabel.text = {
            return String(format: "%.0f", weather.temperature)
        }()
    }
}
