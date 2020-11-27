//
//  MoneyServiceTestCase.swift
//  BundleTests
//
//  Created by BOUHADEB Yacoub on 10/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

@testable import Bundle
import XCTest

class MoneyServiceTestCase: XCTestCase {

    func testGivenMoneyShouldPostFailedCallbackIfError() {
        // Given
        let moneyService = MoneyService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        moneyService.getUsdRate { (success, money) in
            XCTAssertFalse(success)
            XCTAssertNil(money)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenMoneyShouldPostFailedCallbackIfNoData() {
        // Given
        let moneyService = MoneyService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        moneyService.getUsdRate { (success, money) in
            XCTAssertFalse(success)
            XCTAssertNil(money)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenMoneyShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let moneyService = MoneyService(session: URLSessionFake(data: FakeResponseData.moneyCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        moneyService.getUsdRate { (success, money) in
            XCTAssertFalse(success)
            XCTAssertNil(money)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenMoneyShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let moneyService = MoneyService(session: URLSessionFake(data: FakeResponseData.moneyIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        moneyService.getUsdRate { (success, money) in
            XCTAssertFalse(success)
            XCTAssertNil(money)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenMoneyShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        let moneyService = MoneyService(session: URLSessionFake(data: FakeResponseData.moneyCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        let change: Float = 1.127649
        moneyService.getUsdRate { (success, money) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(money)
            
            XCTAssertEqual(change, money!.usdRate)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
}
