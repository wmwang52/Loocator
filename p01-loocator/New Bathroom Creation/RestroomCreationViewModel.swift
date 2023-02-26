//
//  NewBathroomViewModel.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import CoreLocation
import Foundation
@MainActor

class RestroomCreationViewModel: ObservableObject {
    @Published var creationState: RestroomCreationState = .input
    
    private let geocoder = CLGeocoder()
    private let service = RestroomCreationService()
    private let locationManager = LocationManager()
    
    @Published var isDebugRequest: Bool = true
    @Published var facilityName: String = ""
    @Published var roomNumber: String = ""
    @Published var floorNumber: String = ""
    @Published var streetAddress: String = ""
    @Published var city: String = ""
    @Published var state: String = ""
    @Published var country: String = ""
    @Published var accessible: Bool = false
    @Published var genderNeutral: Bool = false
    @Published var changingTable: Bool = false
    @Published var directions: String = ""
    @Published var distance: Double = 0.0
    
    
    init() {
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    public func reset() {
        facilityName = ""
        roomNumber = ""
        floorNumber = ""
        streetAddress = ""
        city = ""
        state = ""
        country = ""
        accessible = false
        genderNeutral = false
        changingTable = false
        directions = ""
        distance = 0.0
    }
    
    public func createRestroomWithCurrentLocation() {
            locationManager.requestLocation()
    }
    
    var restroomIsValid: Bool {
        facilityName.isEmpty == false
            && streetAddress.isEmpty == false
            && city.isEmpty == false
            && state.isEmpty == false
            && country.isEmpty == false
    }
    
    private func createBuilder(with location: Location) -> RestroomBuilder {
        RestroomBuilder(facilityName: facilityName,
                        roomNumber: roomNumber.isEmpty ? nil : roomNumber,
                        floorNumber: floorNumber.isEmpty ? nil : floorNumber,
                        directions: directions.isEmpty ? nil : directions,
                        streetAddress: streetAddress,
                        city: city,
                        state: state,
                        country: country,
                        latitude: location.latitude,
                        longitude: location.longitude,
                        distance: distance,
                        accessible: accessible,
                        genderNeutral: genderNeutral,
                        changingTable: changingTable)
    }
    
    private func createRestroom(for builder: RestroomBuilder) {
        Task {
            do {
                try await service.createRestroom(for: builder, isDebugRequest: isDebugRequest)
                
                creationState = .success(message: "Successfully Created Restroom at \(Date())")
            } catch {
                creationState = .failed(message: error.localizedDescription)
            }
        }
    }
}

extension RestroomCreationViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        if restroomIsValid {
            creationState = .loading
            // NEED TO CHANGE THIS
            createRestroom(for: createBuilder(with: location))
        } else {
            let Newlocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            geocoder.reverseGeocodeLocation(Newlocation, completionHandler: { placemarks, error in
                if error != nil {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                let pm = placemarks! as [CLPlacemark]

                self.streetAddress = (pm[0].subThoroughfare ?? "") +
                    " " + (pm[0].thoroughfare ?? "")
                self.city = pm[0].locality ?? ""
                self.state = pm[0].administrativeArea ?? ""
                self.country = pm[0].isoCountryCode ?? ""
                
            })
        }
    }
    
    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        creationState = .failed(message: "\(error)")
    }
}
