//
//  RestroomSearchView.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import SwiftUI

struct RestroomSearchView: View {
    @StateObject private var vm = RestroomsSearchViewModel()
    var body: some View {
        List {
            locationInputFields
            
            Button("Find Restrooms") {
                vm.startRestroomSearch()
            }
            
            if let errorMessage = vm.errorMessage {
                Section("Error Message") {
                    Text(errorMessage)
                }
            } else if !(vm.LoadingMessage == ""){
                Section("Results") {
                    Text(vm.LoadingMessage)
                }
            }else if !vm.restrooms.isEmpty {
                Section("Results") {
                    restroomResultsList
                }
            }
        }
    }
    
    private var locationInputFields: some View {
        Section("Latitude & Longitude") {
            TextField("Latitude", text: $vm.latitude)
            TextField("Longitude", text: $vm.longitude)
        }
        .keyboardType(.numberPad)
        .onSubmit { vm.startRestroomSearch() }
    }
    
    private var restroomResultsList: some View {
        ForEach(vm.restrooms) { restroom in
            VStack(alignment: .leading) {
                Text(restroom.name)
                    .font(.callout)
                
                Text(restroom.address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RestroomSearchView().navigationTitle("Loocator")
        }
    }
}
