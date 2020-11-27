//
//  WeatherService.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation

class WeatherService {
    static var shared = WeatherService()
    private init() {}
    
    // url used for the network call
     private static let weatherParisUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=6ad5fcf8914fb6b0949c6b4d640376d5&id=6455259&units=metric")!
    // url used for the network call
     private static let weatherNewYorkUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=6ad5fcf8914fb6b0949c6b4d640376d5&id=5128581&units=metric")!
    
     private var task: URLSessionDataTask?
    
     private var weatherParissession = URLSession(configuration: .default)
     private var weatherNysession = URLSession(configuration: .default)
    
    init(weatherParissession: URLSession, weatherNySession: URLSession) {
        self.weatherParissession = weatherParissession
        self.weatherNysession = weatherNySession
    }

    // This function is a network call
    func getParisWeather(callback: @escaping (Bool, CitysWeather?) -> Void) {
        
    var request = URLRequest(url: WeatherService.weatherParisUrl)
    request.httpMethod = "GET"

    
    task?.cancel()
    task = weatherParissession.dataTask(with: request) { (data, response, error) in
        DispatchQueue.main.async {
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                callback(false, nil)
                return
        }
            self.getNyWeather { (data) in
                guard let dataNy = data else {
                    callback(false, nil)
                    return
                }
                guard let responseJSONNY = try? JSONDecoder().decode(WeatherData.self, from: dataNy) else {
                    callback(false, nil)
                    return
                }
                let cityWheater = CitysWeather(mainParis: responseJSON.weather[0].main, descriptionParis: responseJSON.weather[0].description, tempParis: responseJSON.main.temp, mainNy: responseJSONNY.weather[0].main, descriptionNy: responseJSONNY.weather[0].description, tempNy: responseJSONNY.main.temp)
                callback(true, cityWheater)
                }
            }
        }
        task?.resume()
    }
    
    // This function is a network call
    private func getNyWeather(completionHandler: @escaping (Data?) -> Void) {

        task?.cancel()
        task = weatherNysession.dataTask(with: WeatherService.weatherNewYorkUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                completionHandler(data)
            }
        }
        task?.resume()
    }
    

}

