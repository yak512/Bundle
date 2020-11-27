//
//  FakeResponseData.swift
//  BundleTests
//
//  Created by BOUHADEB Yacoub on 09/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassromms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassromms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class WeatherError: Error {}
    static let errorWeather = WeatherError()
    
    class MoneyError: Error {}
    static let errorMoney = MoneyError()
    
    class QuoteError: Error {}
    static let errorQuote = QuoteError()
    
    class TradError: Error {}
    static let errorTrad = TradError()

     static var wheaterCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var moneyCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Money", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var quoteCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Quote", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var tradCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Traduction", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let moneyIncorrectData = "error".data(using: .utf8)
    static let weatherIncorrectData = "error".data(using: .utf8)
    static let quoteIncorrectData = "error".data(using: .utf8)
    static let tradIncorrectData = "error".data(using: .utf8)


}
