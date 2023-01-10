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
    
    public func findLocation(with query: String, completion: @escaping (([SearchableLocation]) -> Void)) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                print(error)
                return
            }
            
            let locations : [SearchableLocation] = places.compactMap({ place in
                var searchTitle = ""
                
                if let street = place.name {
                    searchTitle += street
                }
                if let city = place.locality {
                    searchTitle += ", \(city)"
                }
                if let region = place.administrativeArea {
                    searchTitle += ", \(region)"
                }
                if let country = place.country {
                    searchTitle += ", \(country)"
                }
                
                let result = SearchableLocation(title: searchTitle, coordinates: place.location?.coordinate)
                return result
            })
            completion(locations)
        }
    }
}
