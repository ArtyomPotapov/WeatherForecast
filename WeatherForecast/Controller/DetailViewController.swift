//
//  DetailViewController.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var weather: Weather?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
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
        
//        viewWeather = weather.
        nameLabel.text = "\(weather.name)"
        statusLabel.text = "\(weather.conditionString)"
        tempLabel.text = "\(weather.temperature)"
        pressureLabel.text = "\(weather.pressure)"
        windLabel.text = "\(weather.windSpeed)"
        minTempLabel.text = "\(weather.feelsLike)"
        maxTempLabel.text = "\(weather.humidity)"
        
        
    }

    func setImage(){
        guard let weather = weather else {return}
        
        let path = Constants.imageBaseURL + weather.icon.rawValue + ".svg"
        let url = URL(string: path)!
        
        
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            print(data)
            DispatchQueue.main.async {
                self.myImageView.image = UIImage(data: data)
                self.loadViewIfNeeded()
            }
        }
        task.resume()
    }

}

//completion: @escaping(UIImage)->()
