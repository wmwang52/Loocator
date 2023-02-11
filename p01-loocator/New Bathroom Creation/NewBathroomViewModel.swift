//
//  NewBathroomViewModel.swift
//  p01-loocator
//
//  Created by William Wang on 2/10/23.
//

import Foundation

class NewBathroomViewModel: ObservableObject {
    
    private let service = NewBathroomService()
    @Published var newTitle = ""
    @Published var NewRestroomsList: [NewRestroom] = []

    func createBathroom(title: String) {
        Task {
            do {
                let builder = NewRestroomBuilder(title: title)
                let newRestroom = try await service.createTodo(builder: builder)
                NewRestroomsList.append(newRestroom)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
