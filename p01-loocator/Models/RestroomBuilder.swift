//
//  RestroomCreation.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import Foundation

struct RestroomBuilder: Codable {
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
}
