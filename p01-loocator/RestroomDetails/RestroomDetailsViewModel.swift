//
//  RestroomDetailsViewModel.swift
//  p01-loocator
//
//  Created by William Wang on 3/7/23.
//

import Foundation

@MainActor
class RestroomDetailsViewModel: ObservableObject {
    private let service = RestroomsService()
    
    @Published var restroom: Restroom
    let didUpdateRestroom: (Restroom) -> Void
    let didDeleteRestroom: (Restroom) -> Void
    
    init(restroom: Restroom, didUpdateRestroom: @escaping (Restroom) -> Void, didDeleteRestroom: @escaping (Restroom) -> Void) {
        self.restroom = restroom
        self.didUpdateRestroom = didUpdateRestroom
        self.didDeleteRestroom = didDeleteRestroom
    }

    func upvote() {
        Task {
            do {
                let upvote = try await service.upvote(id: restroom.id)
                didUpdateRestroom(upvote)

                self.restroom = upvote
                
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }
        
        // TODO: Call service.upvote
        // - on success, call `didUpdateRestroom` and update `self.restrooms` with its result
        // - on failure, handle error in some way (up to you)
    }
    
    func downvote() {
        Task {
            do {
                let downvote = try await service.downvote(id: restroom.id)
                
                self.restroom = downvote
                didUpdateRestroom(downvote)

            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }
        // TODO: Call service.downvote
        // - on success, call `didUpdateRestroom` and update `self.restrooms` with its result
        // - on failure, handle error in some way (up to you)
    }
    
    func delete() {
        Task {
            do {
                try await service.delete(id: restroom.id)
                didDeleteRestroom(self.restroom)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        // TODO: Call service.delete
        // - on success, call `didDeleteRestroom`
        // - on failure, handle error in some way (up to you)
    }
}
