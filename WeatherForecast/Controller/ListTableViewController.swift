//
//  ListTableViewController.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let networkManager = NetworkManager()
    var citiesWeatherArray = [Weather](){
        willSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        loadWeatherArray()
        citiesWeatherArray = Array(repeating: Weather(), count: cityNamesArray.count)
    }
    
    func loadWeatherArray(){

        for index in 0...cityNamesArray.count-1{
        
                self.getCoordinate(from: cityNamesArray[index]) { coordinate, error in
                    
                    guard let coordinate = coordinate else { return }
                    
                    self.networkManager.requestWeatherData(latitude: coordinate.latitude, longitude: coordinate.longitude) {  weather in
                        var cityWeather = weather
                        cityWeather.name = cityNamesArray[index]
                        self.citiesWeatherArray[index] = cityWeather
                        
                    }
                }
            }
    }
    
    func someFunc(weather: Weather, completion: @escaping(Weather)->()){
        completion(weather)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesWeatherArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        
        cell.setLabels(weather: citiesWeatherArray[indexPath.row])
        
        return cell
    }
    
}
