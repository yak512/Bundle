//
//  MoneyService.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 04/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation

class MoneyService {
    static var shared = MoneyService()
    private init() {}
    private static let rateUsdUrl = URL(string: "http://data.fixer.io/api/latest?access_key=0ec77acae3e4285d793c4f4237f8a528&symbols=USD")!
    private var task: URLSessionDataTask?
    
    func getUsdRate(callback: @escaping (Bool, MoneyRateResponse?) -> Void) {
        var request = URLRequest(url: MoneyService.rateUsdUrl)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(MoneyRate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let moneyRate = MoneyRateResponse(usdRate: responseJSON.rates.usdRate)
                callback(true, moneyRate)
            }
        }
        task?.resume()
    }
    
}
