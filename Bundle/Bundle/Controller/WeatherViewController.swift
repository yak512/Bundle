//
//  WeatherViewController.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 03/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    
    // MARK: OUTLETS
    
    @IBOutlet weak var descriptionWeatherParis: UILabel!
    @IBOutlet weak var tempWeatherParis: UILabel!
    
    
    @IBOutlet weak var descriptionWeatherNy: UILabel!
    @IBOutlet weak var tempWeatherNy: UILabel!
    
    
    // MARK: View Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        showWeather()
    }
    
    
    // MARK: functions
    
    private func showWeather() {
        WeatherService.shared.getParisWeather { (success, citysWeather) in
            if success, let citysWeather = citysWeather {
                self.update(citysWeather: citysWeather)

            } else {
                self.presentAlert()
            }
        }
    }
    
    private func update(citysWeather: CitysWeather) {
        descriptionWeatherParis.text = citysWeather.mainParis + ", " + citysWeather.descriptionParis
        tempWeatherParis.text = "\(citysWeather.tempParis) °C"
        
        descriptionWeatherNy.text = citysWeather.mainNy + ", " + citysWeather.descriptionNy
        tempWeatherNy.text = "\(citysWeather.tempNy) °C"
    }
    
    // This function is called when we have an error
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The network request failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
