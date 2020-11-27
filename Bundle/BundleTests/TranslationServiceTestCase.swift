//
//  TranslationServiceTestCase.swift
//  BundleTests
//
//  Created by BOUHADEB Yacoub on 20/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

@testable import Bundle
import XCTest

class TranslationServiceTestCase: XCTestCase {

    func testGivenTranslationShouldPostFailedCallbackIfError() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTrad))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        translationService.getTranslation(text: "", tar: "", src: "", callback: { (success, trad) in
            XCTAssertFalse(success)
            XCTAssertNil(trad)
            exception.fulfill()
        })
    wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenTranslationShouldPostFailedCallbackIfNoData() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        translationService.getTranslation(text: "", tar: "", src: "", callback: { (success, trad) in
            XCTAssertFalse(success)
            XCTAssertNil(trad)
            exception.fulfill()
        })
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.tradCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        translationService.getTranslation(text: "", tar: "", src: "", callback: { (success, trad) in
            XCTAssertFalse(success)
            XCTAssertNil(trad)
            exception.fulfill()
        })
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.tradIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        translationService.getTranslation(text: "", tar: "", src: "", callback: { (success, trad) in
            XCTAssertFalse(success)
            XCTAssertNil(trad)
            exception.fulfill()
        })
        wait(for: [exception], timeout: 0.01)
    }
    
    func testGivenTranslationShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.tradCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let exception = XCTestExpectation(description: "Wait for queue change")
        translationService.getTranslation(text: "Hello", tar: "fr", src: "en", callback: { (success, trad) in
            XCTAssertTrue(success)
            XCTAssertNotNil(trad)
            
            XCTAssertEqual("Hi" , trad?.translatedText)

            exception.fulfill()
        })
        wait(for: [exception], timeout: 0.01)
    }
}
