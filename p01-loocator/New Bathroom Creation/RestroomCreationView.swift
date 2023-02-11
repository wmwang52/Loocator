//
//  RestroomCreationView.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import SwiftUI

struct RestroomCreationView: View {
    @StateObject private var vm = NewBathroomViewModel()

    var body: some View {
        List {
            Section("Create") {
                TextField("New todo title", text: $vm.newTitle)
                Button("Create ToDo") {
                    vm.createBathroom(title: vm.newTitle)
                }
            }

            Section("Todo List") {
                Text("HEllo")
            }
        }
        .navigationTitle("Todo List")
    }
}

struct RestroomCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RestroomCreationView()
                .navigationTitle("Restroom Creation")
        }
    }
}
