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
        
        var components = URLComponents(string: "https://learning.appteamcarolina.com/loocator/search")
        components?.queryItems = [URLQueryItem(name: "latitude", value: "\(latitude)"), URLQueryItem(name: "longitude", value: "\(longitude)")]
        
//        print(components)
        guard let url = components?.url else { fatalError("Invalid URl") }
        let (data, _) = try await session.data(from: url)
        // Note: you must provide the `latitude` and `longitude` query parameters
//        print(try! decoder.decode([Restroom].self, from: data))
        // Example: https://learning.appteamcarolina.com/loocator/search?latitude=35.9&longitude=-79
        
        let Restrooms = try decoder.decode([Restroom].self, from: data)
        return Restrooms
    }
}
