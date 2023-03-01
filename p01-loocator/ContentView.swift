//
//  ContentView.swift
//  p01-loocator
//
//  Created by Samuel Shi on 1/26/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingSheet = false
    var body: some View {
        NavigationStack {
            RestroomSearchView().navigationTitle("Loocator")

                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingSheet.toggle()

                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }

        }.sheet(isPresented: $isShowingSheet) {
            RestroomCreationView()
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
