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
    var id: UUID
    var facilityName: String
    var roomNumber: String?
    var floorNumber: String?
    var directions: String?
    var streetAddress: String
    var city: String
    var state: String
    var country: String
    var latitude: Double
    var longitude: Double
    var distance: Double?
    var accessible: Bool
    var genderNeutral: Bool
    var changingTable: Bool
    var createdAt: Date
    var updatedAt: Date
    var downvotes: Int
    var upvotes: Int
}

// MARK: Computed Properties

extension Restroom {
    var address: String {
        "\(streetAddress)\n\(city.capitalized), \(state)"
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

extension Restroom{
    static var example: Restroom {
        Restroom(id: UUID(), facilityName: "TEST", streetAddress: "TEST", city: "TEST", state: "TEST", country: "TEST", latitude: 0.0, longitude: 0.0, accessible: true, genderNeutral: true, changingTable: true, createdAt: Date(), updatedAt: Date(), downvotes: 0, upvotes: 0)
    }
}
