//
//  Money.swift
//  Bundle
//
//  Created by BOUHADEB Yacoub on 04/04/2019.
//  Copyright © 2019 BOUHADEB Yacoub. All rights reserved.
//

import Foundation

struct MoneyRate: Codable {
    
    struct Rates: Codable {
        let usdRate: Float
        
        enum CodingKeys : String, CodingKey {
            case usdRate = "USD"
        }
    }

   let rates: Rates
}

struct MoneyRateResponse {
    let usdRate: Float
}
