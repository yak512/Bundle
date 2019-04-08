//
//  QuoteService.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 08/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation

class QuoteService {
    static var shared = QuoteService()
    
    private init() {}
    
    private static let quoteUrl = URL(string: "https://api.forismatic.com/api/1.0/")!
    
    
    private var task: URLSessionDataTask?
    
    func getQuote(callback: @escaping (Bool, Quote?) -> Void) {
        var request = URLRequest(url: QuoteService.quoteUrl)
        request.httpMethod = "POST"
        
        let body = "method=getQuote&format=json&lang=en"
        request.httpBody = body.data(using: .utf8)
        
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
                guard let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                    let text = responseJSON["quoteText"],
                    let author = responseJSON["quoteAuthor"] else {
                        callback(false, nil)
                        return
                }
                let quote = Quote(text: text, author: author)
                callback(true, quote)
            }
        }
        task?.resume()
    }
}
