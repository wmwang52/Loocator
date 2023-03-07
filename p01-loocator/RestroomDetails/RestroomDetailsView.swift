//
//  RestroomDetailsView.swift
//  p01-loocator
//
//  Created by Samuel Shi on 3/5/23.
//

import SwiftUI

struct RestroomDetailsView: View {
    // TODO: Find dismiss action in the environment
    @StateObject var vm: RestroomDetailsViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            votes
            address
            roomNumber
            attributes
            details
        }
        .navigationTitle(vm.restroom.facilityName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.delete()
                    dismiss()
                } label: {
                    Text("Delete")
                }
            }
        }
    }
    
    private var votes: some View {
        Section("Votes") {
            Button {
                vm.upvote()
            } label: {
                HStack {
                    Image(systemName: "hand.thumbsup")
                    Text("\(vm.restroom.upvotes)")
                }
                .foregroundColor(.green)
            }
            Button {
                vm.downvote()
            } label: {
                HStack {
                    Image(systemName: "hand.thumbsdown")
                    Text("\(vm.restroom.downvotes)")
                }
                .foregroundColor(.red)
            }
        }
    }
    
    private var address: some View {
        Section("Address") {
            Text(vm.restroom.address)
        }
    }
    
    @ViewBuilder private var roomNumber: some View {
        Section("Room number") {
            Text(vm.restroom.roomNumber ?? "")
        }
    }
    
    @ViewBuilder private var details: some View {
        Section("Directions") {
            Text(vm.restroom.directions ?? "")
        }
        
        Section("Floor number") {
            Text(vm.restroom.floorNumber ?? "")
        }
    }
    
    private var attributes: some View {
        Section("Attributes") {
            RestroomAttributeView(title: "Accessible", systemIcon: "figure.roll", isOn: vm.restroom.accessible)
            RestroomAttributeView(title: "Gender Neutral", systemIcon: "figure.dress.line.vertical.figure", isOn: vm.restroom.genderNeutral)
            RestroomAttributeView(title: "Changing Table", systemIcon: "figure.and.child.holdinghands", isOn: vm.restroom.changingTable)
        }
    }
}

struct RestroomDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let vm = RestroomDetailsViewModel(restroom: .example, didUpdateRestroom: { _ in }, didDeleteRestroom: { _ in })
            RestroomDetailsView(vm: vm)
        }
    }
}
