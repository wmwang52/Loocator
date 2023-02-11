//
//  Restroom.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import Foundation



// MARK: Example JSON

// {
//     "id": 21459,
//     "name": "Market Street Coffee & Ice Cream",
//     "street": "503 Meadowmont Village Circle",
//     "city": "Chapel Hill",
//     "state": "NC",
//     "country": "US",
//     "latitude": 35.9054316,
//     "longitude": -79.0107771,
//     "distance": 0.7103795040209431,
//     "accessible": true,
//     "unisex": true,
//     "changingTable": false,
//     "directions": "At the back on the left, before the curtain",
//     "createdAt": "2016-01-17T05:00:00Z", # This will be of type `Date`
//     "updatedAt": "2016-01-17T05:00:00Z", # This will be of type `Date`
//     "downvote": 0,
//     "upvote": 0
// }

// MARK: Model Definition

struct Restroom: Codable, Identifiable {
    var id: Int
    var name: String
    var street: String
    var city: String
    var state: String
    var country: String
    var latitude: Double
    var longitude: Double
    var distance: Double
    var accessible: Bool
    var unisex: Bool
    var changingTable: Bool
    var directions: String?
    var createdAt: Date
    var updatedAt: Date
    var downvote: Int
    var upvote: Int
}

// MARK: Computed Properties

extension Restroom {
    var address: String {
        "\(street)\n\(city.capitalized), \(state)"
    }
}

// MARK: JSONDecoder

extension Restroom {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
