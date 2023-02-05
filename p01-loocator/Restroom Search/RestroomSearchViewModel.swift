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
    private let locationManager = LocationManager()

    var latitude: String = "35"
    var longitude: String = "-79"
    
    @Published var restrooms: [Restroom] = []
    @Published var errorMessage: String? = nil
    
    @Published var state: LocationLoadingState = .idle
    
    private func setRestrooms(restrooms: [Restroom]) {
        self.restrooms = restrooms
        errorMessage = nil
    }
    
    private func setError(message: String) {
        errorMessage = message
        restrooms = []
    }
    
    public func startRestroomSearch() {
        state = .loading
        locationManager.requestLocation()
    }
    
    init() {
        locationManager.delegate = self
    }
}

enum LocationLoadingState {
    case idle
    case loading
    case success(location: Location)
    case error(message: String)
}

extension RestroomsSearchViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        state = .success(location: location)
        
        Task {
            do {
                let restrooms = try await service.searchRestrooms(latitude: location.latitude, longitude: location.longitude)
                setRestrooms(restrooms: restrooms)
            } catch {
                setError(message: error.localizedDescription)
            }
        }
    }
    
    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        state = .error(message: error.localizedDescription)
    }
}
