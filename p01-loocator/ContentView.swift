//
//  ContentView.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            RestroomSearchView().navigationTitle("Loocator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
