//
//  UnitConversion.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/9/23.
//

import Foundation

class UnitConverter {
    static let shared = UnitConverter()
    
    // meters to miles
    func metersToMiles(meters: Double?) -> Double {
        guard let meters = meters else {
            return 0
        }
        
        let miles =  meters / 1609.344
        return round(miles * 10) / 10
    }
}
