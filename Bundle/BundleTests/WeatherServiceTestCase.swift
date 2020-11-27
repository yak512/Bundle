//
//  WeatherServiceTestCase.swift
//  BundleTests
//
//  Created by BOUHADEB Yacoub on 09/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

@testable import Bundle

import XCTest

class WeatherServiceTestCase: XCTestCase {

    func testGivenWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather), weatherNySession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, wheater) in
            XCTAssertFalse(success)
            XCTAssertNil(wheater)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: nil, response: nil, error: nil), weatherNySession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, wheater) in
            XCTAssertFalse(success)
            XCTAssertNil(wheater)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseKO, error: nil), weatherNySession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, wheater) in
            XCTAssertFalse(success)
            XCTAssertNil(wheater)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil), weatherNySession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, wheater) in
            XCTAssertFalse(success)
            XCTAssertNil(wheater)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
   
    func testGivenWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseOK, error: nil), weatherNySession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let temp: Float = 10.93
        let main = "Haze"
        let description = "haze"
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, weather) in
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            
            XCTAssertEqual(temp, weather!.tempParis)
            XCTAssertEqual(main, weather!.mainParis)
            XCTAssertEqual(description, weather!.descriptionParis)
            XCTAssertEqual(temp, weather!.tempNy)
            XCTAssertEqual(main, weather!.mainNy)
            XCTAssertEqual(description, weather!.descriptionNy)
            
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenWeatherShouldPostFailedNotificationIfNoNywheatherData() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseOK, error: nil), weatherNySession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, wheater) in
            XCTAssertFalse(success)
            XCTAssertNil(wheater)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenWeatherShouldPostFailedNotificationIfErrorWithWheatherNy() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseOK, error: nil), weatherNySession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseOK, error: FakeResponseData.errorWeather))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, wheater) in
            XCTAssertFalse(success)
            XCTAssertNil(wheater)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenWeatherShouldPostFailedNotificationIfIncorrectResponseWhithNy() {
        // Given
        let weatherService = WeatherService(weatherParissession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseOK, error: nil), weatherNySession: URLSessionFake(data: FakeResponseData.wheaterCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        weatherService.getParisWeather { (success, wheater) in
            XCTAssertFalse(success)
            XCTAssertNil(wheater)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
}
