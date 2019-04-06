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
    
    private static let translateURL =  URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBRUg2M1c5g6RDODc3IiwEa05RamnrvIas")!
    
    private var task: URLSessionDataTask?
    
    func getTranslation(text: String, tar: String, src: String, callback: @escaping (Bool, Translated?) -> Void) {
        var request = URLRequest(url: TranslationService.translateURL)
        request.httpMethod = "POST"
        
        let q = text
        let target = tar
        let source = src
        
        let body = "&q=" + q + "&target=" + target + "&source=" + source
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
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
