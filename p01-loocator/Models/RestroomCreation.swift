//
//  RestroomCreation.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import Foundation

struct NewRestroom: Identifiable, Codable {
    let id: UUID
    var latitude: Double
    var longitude: Double
}

struct NewRestroomBuilder: Codable{
    let title: String
}

enum NewRestroomLoadingState {
    case idle
    case loading
    case success([NewRestroom])
    case error(String)
}

