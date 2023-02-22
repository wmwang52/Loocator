//
//  NewBathroomListService.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import Foundation
@MainActor

struct RestroomCreationService {
    private let session = URLSession.shared
    private let decoder: JSONDecoder = Restroom.decoder
    private let encoder = JSONEncoder()

    // Send isDebug Request as query parameter
    func createRestroom(for builder: RestroomBuilder, isDebugRequest: Bool) async throws -> Restroom {
        guard let url = URL(string: "https://learning.appteamcarolina.com/loocator/restrooms") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.url?.append(queryItems: [URLQueryItem(name: "debug", value: "\(isDebugRequest)")])

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoded = try encoder.encode(builder)
        request.httpBody = encoded

        let (data, _) = try await session.data(for: request)
        
        let restroom = try decoder.decode(Restroom.self, from: data)
        return restroom
    }
}
