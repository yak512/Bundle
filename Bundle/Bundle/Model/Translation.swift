//
//  Translation.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 06/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation

struct Translate: Codable {
    
    struct Translation: Codable {
       let  translatedText: String
    }
    
    struct Data : Codable {
        let  translations: [Translation]
    }
    
    let data: Data
}

struct Translated {
    let translatedText: String
}
