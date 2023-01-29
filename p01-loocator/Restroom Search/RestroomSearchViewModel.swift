//
//  RestroomSearchViewModel.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import Foundation

@MainActor
class RestroomsSearchViewModel: ObservableObject {
    private let service = RestroomSearchService()
    
    @Published var latitude: String = "35.9132"
    @Published var longitude: String = "-79.0558"
    
    @Published var restrooms: [Restroom] = []
    @Published var errorMessage: String? = nil
    
    private func setRestrooms(restrooms: [Restroom]) {
        self.restrooms = restrooms
        self.errorMessage = nil
    }
    
    private func setError(message: String) {
        self.errorMessage = message
        self.restrooms = []
    }
    
    public func startRestroomSearch() {
        guard let latitude = Double(latitude), let longitude = Double(longitude) else {
            setError(message: "Invalid latitude or longitude")
            return
        }
        
        // TODO: Make a call to `service.searchRestrooms` and handle the error well
        // To update the restrooms, you should use the `setRestrooms(...)` method to make sure
        // To handle the error, you should call `setError(...)` and use `error.localizedDescription` as the message
    }
}
