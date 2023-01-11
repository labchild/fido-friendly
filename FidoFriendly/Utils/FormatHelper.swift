//
//  FormatHelper.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/9/23.
//

import Foundation

class FormatHelper {
    static let shared = FormatHelper()
    
    // meters to miles
    func metersToMiles(meters: Double?) -> Double {
        guard let meters = meters else {
            return 0
        }
        
        let miles =  meters / 1609.344
        return round(miles * 10) / 10
    }
    
    // Location model to readable address string (multi-line)
    func formatToMultiLineAddress(location: Location?) -> String {
        guard let location = location else { return "Not Listed" }
        var addressString = ""
        
        if let street = location.address {
            addressString += street
        }
        if let city = location.city {
            addressString += "\n\(city)"
        }
        if let region = location.region {
            addressString += ", \(region)"
        }
        if let postcode = location.postcode {
            addressString += " \(postcode)"
        }
        if let country = location.country {
            addressString += "\n \(country)"
        }
        
        return addressString
    }
}
