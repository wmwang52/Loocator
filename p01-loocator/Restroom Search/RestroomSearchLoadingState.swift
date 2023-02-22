//
//  RestroomSearchLoadingState.swift
//  p01-loocator
//
//  Created by William Wang on 2/22/23.
//

import Foundation

enum RestroomSearchLoadingState {
    case idle
    case loading
    case success(restrooms: [Restroom])
    case error(message: String)
}
