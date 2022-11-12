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
        willSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
        }
    }
    var filterCitiesWeatherArray = [Weather]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool{
        return searchController.searchBar.text != nil ? true : false
    }
    
    var isFiltering: Bool {
        return searchController.isActive && searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        loadWeatherArray()
        
        citiesWeatherArray = Array(repeating: Weather(), count: cityNamesArray.count)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
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
        return isFiltering ? filterCitiesWeatherArray.count : citiesWeatherArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        if isFiltering {
            cell.setLabels(weather: filterCitiesWeatherArray[indexPath.row])
        } else {
                cell.setLabels(weather: citiesWeatherArray[indexPath.row])
            }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController_id") as! DetailViewController
        if isFiltering {
            detailVC.weather = filterCitiesWeatherArray[indexPath.row]
        } else {
            detailVC.weather = citiesWeatherArray[indexPath.row]
        }
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
        addAlert(title: "Новый город", placeholder: "Введите название") { string in
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

extension ListTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    func filterContentForSearchText(_ searchText: String){
        filterCitiesWeatherArray = citiesWeatherArray.filter{ weather in
            weather.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
