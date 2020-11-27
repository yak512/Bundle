//
//  TranslationService.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 06/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation

class TranslationService {
    static var shared = TranslationService()
    private init() {}
    
    // url used for the network call
    private static let translateURL =  URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBRUg2M1c5g6RDODc3IiwEa05RamnrvIas")!
    
    private var task: URLSessionDataTask?
    
    private var tradSession = URLSession(configuration: .default)
    
    init(session: URLSession) {
        tradSession.self = session
    }
    
    // This function is a network call
    func getTranslation(text: String, tar: String, src: String, callback: @escaping (Bool, Translated?) -> Void) {
        var request = URLRequest(url: TranslationService.translateURL)
        request.httpMethod = "POST"
        
        let q = text
        let target = tar
        let source = src
        
        let body = "&q=" + q + "&target=" + target + "&source=" + source
        request.httpBody = body.data(using: .utf8)
        
        task = tradSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                    }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                    }
                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let translatedText = Translated(translatedText: responseJSON.data.translations[0].translatedText)
                callback(true, translatedText)
                }
            }
        task?.resume()
    }
}
