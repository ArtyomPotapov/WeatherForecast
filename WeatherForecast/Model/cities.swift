//
//  cities.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 10.11.2022.
//

import Foundation
import CoreLocation

let citiesArray = ["Москва","Мурманск","Новосибирск","Владивосток","Оренбург","Рио-де-Жанейро"]

extension ListTableViewController{
    
    func getCoordinate(from city: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?)->()){
        
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            
            completion(placemarks?.first?.location?.coordinate, error)
        }
    }
}
