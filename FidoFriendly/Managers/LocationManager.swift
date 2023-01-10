//
//  LocationManager.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/10/23.
//

import Foundation
import CoreLocation

struct SearchableLocation {
    let title: String?
    let coordinates: CLLocationCoordinate2D?
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    public func findLocation(with query: String, completion: @escaping (([SearchableLocation]) -> Void)) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            
            let models: [SearchableLocation] = places.map({ place in
                var searchTitle = ""
                
                if let street = place.name {
                    searchTitle += street
                }
                if let city = place.locality {
                    searchTitle += city
                }
                if let region = place.administrativeArea {
                    searchTitle += region
                }
                if let country = place.country {
                    searchTitle += country
                }
                    
                let result = SearchableLocation(title: searchTitle, coordinates: place.location?.coordinate)
                    
                return result
            })
            completion(models)
        }
    }
}
