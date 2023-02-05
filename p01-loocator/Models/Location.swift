//
//  Location.swift
//  p01-loocator
//
//  Created by William Wang on 2/5/23.
//

import Foundation

struct Location {
    var latitude: Double
    var longitude: Double
}

extension Location: CustomStringConvertible {
    var description: String {
        return "latitude: \(latitude), Longitude: \(longitude)"
    }
}
