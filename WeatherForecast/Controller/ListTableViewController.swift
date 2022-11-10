//
//  ListTableViewController.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

import UIKit
import CoreLocation

class ListTableViewController: UITableViewController {
    
    let networkManager = NetworkManager()
    var citiesWeatherArray = [Weather](){
        didSet {
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
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesWeatherArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        cell.setLabels(weather: citiesWeatherArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController_id") as! DetailViewController
        detailVC.weather = citiesWeatherArray[indexPath.row]
        print(citiesWeatherArray[indexPath.row])
        present(detailVC, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHandler  in
            
            self.citiesWeatherArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        addAddressAlert(title: "Новый город", placeholder: "Введите название") { string in
            self.getCoordinate(from: string) { coordinate, error in
                guard let coordinate = coordinate else {return}
                self.networkManager.requestWeatherData(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                    var newWeather = weather
                    newWeather.name = string
                    self.citiesWeatherArray.append(newWeather)
                }
                
            }
        }
    }
    
    
}
