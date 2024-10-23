//
//  FeatureFlagClient.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

// TODO: Comment
protocol FeatureFlagClient {
    var startTaskWithProviderOnline: Bool { get set }
    var providerJoinsMidExercise: Bool { get set }
}

class FeatureFlagClientImpl: FeatureFlagClient {
    
    static let shared = FeatureFlagClientImpl()
    private init() { }
    
    var startTaskWithProviderOnline = false
    var providerJoinsMidExercise = false
    
}
