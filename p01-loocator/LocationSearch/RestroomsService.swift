//
//  RestroomsService.swift
//  p01-loocator
//
//  Created by William Wang on 3/7/23.
//

import Foundation

struct RestroomsService {
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = Restroom.decoder
    private let encoder: JSONEncoder = .init()
}

extension RestroomsService {
    public func search(latitude: Double, longitude: Double) async throws -> [Restroom] {
        // TODO: Implement this service method by making a request to the following URL
        // https://learning.appteamcarolina.com/loocator/search

        var components = URLComponents(string: "https://learning.appteamcarolina.com/loocator/restrooms")
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

extension RestroomsService {
    public func create(for builder: RestroomBuilder, isDebugRequest: Bool) async throws -> Restroom {
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
        print(restroom)
        return restroom
    }
}

extension RestroomsService {
    public func upvote(id: UUID) async throws -> Restroom {
        guard let url = URL(string: "https://learning.appteamcarolina.com/loocator/restrooms/\(id)/upvote") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoded = try encoder.encode(id)
        request.httpBody = encoded

        let (data, _) = try await session.data(for: request)

        let restroom = try decoder.decode(Restroom.self, from: data)
        return restroom
    }

    // TODO: Implement upvote functionality against "POST /restrooms/<id>/upvote" endpoint

    public func downvote(id: UUID) async throws -> Restroom {
        guard let url = URL(string: "https://learning.appteamcarolina.com/loocator/restrooms/\(id)/downvote") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)

        let encoded = try encoder.encode(id)
        request.httpBody = encoded

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await session.data(for: request)
        let restroom = try decoder.decode(Restroom.self, from: data)
        return restroom
    }
}

// MARK: Delete

extension RestroomsService {
    public func delete(id: UUID) async throws {
        guard let url = URL(string: "https://learning.appteamcarolina.com/loocator/restrooms/\(id)") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)

        let encoded = try encoder.encode(id)
        request.httpBody = encoded

        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        try await session.data(for: request)
    }
}
