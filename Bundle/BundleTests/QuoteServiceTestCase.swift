//
//  QuoteServiceTestCase.swift
//  BundleTests
//
//  Created by BOUHADEB Yacoub on 17/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

@testable import Bundle
import XCTest

class QuoteServiceTestCase: XCTestCase {

    func testGivenQuoteShouldPostFailedCallbackIfError() {
        let quoteService = QuoteService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorQuote))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenQuoteShouldPostFailedCallbackIfNoData() {
        let quoteService = QuoteService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenQuoteShouldPostFailedCallbackIfIncorrectResponse() {
        let quoteService = QuoteService(session: URLSessionFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenQuoteShouldPostFailedCallbackIfIncorrectData() {
        let quoteService = QuoteService(session: URLSessionFake(data: FakeResponseData.quoteIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenMoneyShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        let quoteService = QuoteService(session: URLSessionFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let quoteText = "If we have a positive mental attitude, then even when surrounded by hostility, we shall not lack inner peace."
        let author = "Dalai Lama"
        let exception = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            
            XCTAssertEqual(quoteText, quote?.text)
            XCTAssertEqual(author, quote?.author)
            XCTAssertTrue(success)
            XCTAssertNotNil(quote)
            
            
            
            exception.fulfill()
        }
        wait(for: [exception], timeout: 0.01)
    }
    
}
