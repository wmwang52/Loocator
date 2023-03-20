//
//  RestroomCreationMap.swift
//  p01-loocator
//
//  Created by William Wang on 3/20/23.
//

import MapKit
import SwiftUI

struct RestroomCreationMap: UIViewRepresentable {
    @Binding var visibleRegion: MKCoordinateRegion
    
    func makeCoordinator() -> Coordinator {
        // TODO: Instantiate and return a coordinator object
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        // TODO: Instantiate a MKMapView, set its delegate to self, and return it
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(visibleRegion, animated: true)
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.delegate = context.coordinator
        
        // TODO: Update the MKMapView with the new information
        // Note: this method is called when the `visibleRegion` binding changes
    }
}

extension RestroomCreationMap {
    class Coordinator: NSObject, MKMapViewDelegate {
        var myMapView: RestroomCreationMap
        
        init(_ map: RestroomCreationMap) {
            self.myMapView = map
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            myMapView.visibleRegion = mapView.region
        }
        
        // TODO: Implement the Coordinator class to communicate region changes back to SwiftUI-land
        // Hint: You can use the `mapView(_:regionDidChangeAnimated:)` delegate method to catch changes
    }
}
