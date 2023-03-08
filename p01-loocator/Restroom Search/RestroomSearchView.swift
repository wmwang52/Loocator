//
//  RestroomSearchView.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import SwiftUI

@MainActor
struct RestroomSearchView: View {
    @StateObject private var vm = RestroomsSearchViewModel()
    var body: some View {
        NavigationStack {
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
                        
                    case .success(let restrooms):
                        ForEach(restrooms, id: \.id) { restroom in
                            
                            NavigationLink {
                                let vm = RestroomDetailsViewModel(restroom: restroom, didUpdateRestroom: vm.update(updated:), didDeleteRestroom: vm.delete(restroom:))
                                    
                                RestroomDetailsView(vm: vm)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(restroom.facilityName)
                                            .font(.callout)
                                                    
                                        Text(restroom.address)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        
                                        if let distance = restroom.distance {
                                            Text(distance.formatted() + " mi")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                            }
                        }
                        
                    case .error(let message):
                        Text(message)
                    }
                }
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
