//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

import Foundation



class NetworkManager{
    //
    func requestWeatherData(completion: @escaping (Weather)->()){
        guard let url = URL(string: Constants.urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity )
        request.addValue(Constants.keyAPIValue, forHTTPHeaderField: Constants.keyAPI)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, let weatherData = self.parseJSON(withData: data) else {return}
            completion(weatherData)
        }
        session.resume()
        
    }
    
    func parseJSON(withData data: Data) -> Weather?{
        let decoder = JSONDecoder()
        guard let dataModel = try? decoder.decode(WeatherJSONModel.self, from: data) as WeatherJSONModel else {return nil}
        let weather = Weather(weatherJSONModel: dataModel)
        return weather
    }
}
