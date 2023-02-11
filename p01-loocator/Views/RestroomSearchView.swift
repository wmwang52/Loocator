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
            Button("Find Restrooms") {
                vm.startRestroomSearch()
            }
            
            Section("Results") {
                switch vm.state {
                case .idle:
                    Text("No location to show. Please fetch now")
                    
                case .loading:
                    ProgressView()
                    
                case .success:
                    restroomResultsList
                    
                case .error(let message):
                    Text(message)
                }
            }
            
            if let errorMessage = vm.errorMessage {
                Section("Error Message") {
                    Text(errorMessage)
                }
            }
        }
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
