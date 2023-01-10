//
//  DogFriendlyPlace.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/7/23.
//

import Foundation

struct DogFriendlyPlace: Decodable {
    var fsqId: String?
    var placeName: String?
    // let geocode: Geocode
    var categories: [Category]?
    var location: Location?
    var distance: Double?
    var link: String?
    var description: String?
    var tel: String?
    var website: String?
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case fsqId = "fsq_id"
        case placeName = "name"
        // case geocode = "geocodes"
        case categories, location, distance, link, description, tel, website, rating
    }
}

struct Location: Decodable {
    let address: String?
    let city: String?
    let crossStreet: String?
    let region: String?
    let postcode: String?
    let country: String?
    
    private enum CodingKeys: String, CodingKey {
        case address, region, postcode, country
        case city = "locality"
        case crossStreet = "cross_street"
    }
}

struct Category: Decodable {
    let id: Int?
    let name: String?
}
