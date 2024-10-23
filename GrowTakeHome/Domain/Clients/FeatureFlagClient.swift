//
//  FeatureFlagClient.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

// MARK: Client Protocol
protocol FeatureFlagClient {
    var startTaskWithProviderOnline: Bool { get set }
    var providerJoinsMidExercise: Bool { get set }
}
// MARK: Client Implementation

/// Object responsible for storing the flags used to mock behavior.
/// Note, this is a really barebones implementation, it should be improved
/// in order to support data permanence and remote updates and fetching
class FeatureFlagClientImpl: FeatureFlagClient {
    
    static let shared = FeatureFlagClientImpl()
    private init() { }
    
    var startTaskWithProviderOnline = false
    var providerJoinsMidExercise = true
    
}
