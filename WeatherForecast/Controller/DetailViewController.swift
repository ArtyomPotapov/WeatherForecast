//
//  DetailViewController.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

import UIKit
import SwiftSVG

class DetailViewController: UIViewController {
    var weather: Weather?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setImage()
    }
    
    func setLabels(){
        guard let weather = weather else {return}
        nameLabel.text = "\(weather.name)"
        statusLabel.text = "\(weather.conditionString)"
        tempLabel.text = "\(Int(weather.temperature)) °C"
        pressureLabel.text = "\(weather.pressure) мм рт.ст."
        windLabel.text = "\(weather.windSpeed) м/с"
        minTempLabel.text = "\(weather.feelsLike) °C"
        maxTempLabel.text = "\(weather.humidity) %"
    }
    
    func setImage(){
        guard let weather = weather else {return}
        let path = Constants.imageBaseURL + weather.icon.rawValue + ".svg"
        let url = URL(string: path)!
        let image = UIView(SVGURL: url){image in
            image.resizeToFit(self.myView.bounds)
        }
        myView.addSubview(image)
        print(url, image)
    }
}
