//
//  cities.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 10.11.2022.
//

import Foundation
import CoreLocation

let cityNamesArray = ["Москва","Брянск","Воронеж","Саратов","Рязань","Елец", "Ряжск", "Пекин"]

extension ListTableViewController{
    
    func getCoordinate(from city: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?)->()){
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            completion(placemarks?.first?.location?.coordinate, error)
        }
    }
}
