//
//  Weather.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation


struct WeatherData: Codable {
    
    struct Weather: Codable {
        let main: String
        let description: String
    }
    
   struct Main: Codable {
        let temp: Float
    }
    
    let weather: [Weather]
    let main: Main
}

struct CitysWeather {
    let mainParis: String
    let descriptionParis: String
    let tempParis: Float
    
   let mainNy: String
   let descriptionNy: String
    let tempNy: Float
}
