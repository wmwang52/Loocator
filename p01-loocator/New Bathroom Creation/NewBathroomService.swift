//
//  NewBathroomListService.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import Foundation

struct NewBathroomService {
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    
    func createTodo(builder: NewRestroomBuilder) async throws -> NewRestroom {
        guard let url = URL(string: "https://learning.appteamcarolina.com/networking-demo/todos") else{
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoded = try encoder.encode(builder)
        request.httpBody = encoded
        
        let (data, _) = try await session.data(for:request)
        let NewBathroom = try decoder.decode(NewRestroom.self,from: data)
        return NewBathroom
    }
}
