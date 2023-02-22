//
//  RestroomCreationView.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import SwiftUI
@MainActor

struct RestroomCreationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = RestroomCreationViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    illustration
                }
                switch vm.creationState {
                case .input: inputView
                case .loading: ProgressView()
                case .failed(let message): errorView(message: message)
                case .success(let message): successView(message: message)
                }
            }
            .navigationTitle("Add to Loocater")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (vm.creationState == .input) && (vm.restroomIsValid) {
                            vm.createRestroomWithCurrentLocation()
                        }
                    } label: {
                        if (vm.creationState == .input) && (vm.restroomIsValid) {
                            Text("Save")
                        } else {
                            Text("Save")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder private var inputView: some View {
        requestOptions
        location
        address
        attributes
    }
    
    private var illustration: some View {
        Image("Bathroom")
            .resizable()
            .scaledToFit()
            .frame(height: 136)
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
    }
    
    private func successView(message: String) -> some View {
        Section {
            Text(message)
            Button("Dismiss") {
                dismiss()
            }
        }
    }
    
    private func errorView(message: String) -> some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("An error occured")
                    .bold()
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
                               
            Button("Try Again", action: { vm.reset() })
        }
    }
    
    private var requestOptions: some View {
        Section("Request Options") {
            Toggle("Debug Request", isOn: $vm.isDebugRequest)
        }
    }
    
    private var location: some View {
        Section("Location") {
            TextField("Facility Name", text: $vm.facilityName)
            TextField("Room Number (Optional)", text: $vm.roomNumber)
            TextField("Floor Number (Optional)", text: $vm.floorNumber)
            TextField("Directions (Optional)", text: $vm.directions, axis: .vertical)
        }
    }

    private var address: some View {
        Section("Address") {
            TextField("Street", text: $vm.streetAddress)
            TextField("City", text: $vm.city)
            TextField("State", text: $vm.state)
            TextField("Country", text: $vm.country)
        }
    }

    private var attributes: some View {
        Section("Attributes") {
            Toggle("Accessible", isOn: $vm.accessible)
            Toggle("Gender Neutral", isOn: $vm.genderNeutral)
            Toggle("Changing Table", isOn: $vm.changingTable)
        }
    }
}

struct RestroomCreationView_Previews: PreviewProvider {
    static var previews: some View {
        Text("HI")
            .sheet(isPresented: .constant(true)) {
                RestroomCreationView()
            }
    }
}
