//
//  RestroomSearchService.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import Foundation

struct RestroomSearchService {
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = Restroom.decoder
    
    public func searchRestrooms(latitude: Double, longitude: Double) async throws -> [Restroom] {
        // TODO: Implement this service method by making a request to the following URL
        // https://learning.appteamcarolina.com/loocator/search
        
        // Note: you must provide the `latitude` and `longitude` query parameters
        // Example: https://learning.appteamcarolina.com/loocator/search?latitude=35.9&longitude=-79
        
        return []
    }
}
