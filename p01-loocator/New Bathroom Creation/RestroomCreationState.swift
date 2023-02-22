//
//  RestroomCreationState.swift
//  p01-loocator
//
//  Created by William Wang on 2/21/23.
//

import Foundation
enum RestroomCreationState: Equatable {
    case input
    case loading
    case failed(message: String)
    case success(message: String)
}
