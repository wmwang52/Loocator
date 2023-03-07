//
//  RestroomSearchViewModel.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import Foundation

@MainActor
class RestroomsSearchViewModel: ObservableObject {
    private let service = RestroomsService()
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
                let restrooms = try await service.search(latitude: location.latitude, longitude: location.longitude)
                self.state = .success(restrooms: restrooms)

            } catch {
                self.state = .error(message: error.localizedDescription)
            }
        }
    }

    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        self.state = .error(message: error.localizedDescription)
    }

    func update(updated: Restroom) {
        guard case .success(var restrooms) = self.state else { return }
        for index in restrooms.indices {
            if updated.id == restrooms[index].id {
                restrooms[index] = updated
                break
            }
        }

        // TODO: Find the first index in the local restrooms array where the element's id == updated.id
        // TODO: Update the restrooms array at that index to have the value of `updated`
        self.state = .success(restrooms: restrooms)
    }

    func delete(restroom: Restroom) {
        guard case .success(var restrooms) = self.state else { return }
        // TODO: Remove all elements in the array whose ids equal restroom.id
        for index in restrooms.indices {
            if restroom.id == restrooms[index].id {
                restrooms.remove(at: index)
                break
            }
        }
        self.state = .success(restrooms: restrooms)
    }
}
