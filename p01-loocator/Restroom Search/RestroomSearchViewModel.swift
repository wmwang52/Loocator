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

    var latitude: String = ""
    var longitude: String = ""

    @Published var state: RestroomSearchLoadingState = .idle

    public func startRestroomSearch() {
        self.state = .loading
        self.locationManager.requestLocation()
    }

    init() {
        self.locationManager.delegate = self
    }
}

extension RestroomsSearchViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        Task {
            do {
                let restrooms = try await service.searchRestrooms(latitude: location.latitude, longitude: location.longitude)
                self.state = .success(restrooms: restrooms)

            } catch {
                self.state = .error(message: error.localizedDescription)
            }
        }
    }

    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        self.state = .error(message: error.localizedDescription)
    }
}
