//
//  SettingsView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/23/24.
//

import SwiftUI

struct SettingsViewViewModel: Hashable {
    let startTaskWithProviderOnline: Bool
    let providerJoinsMidExercise: Bool
    
    init() {
        self.startTaskWithProviderOnline = FeatureFlagClientImpl.shared.startTaskWithProviderOnline
        self.providerJoinsMidExercise = FeatureFlagClientImpl.shared.providerJoinsMidExercise
    }
    
    func setStartTaskWithProviderOnline(_ value: Bool) {
        FeatureFlagClientImpl.shared.startTaskWithProviderOnline = value
    }
    
    func setProvderJoinsMidExercise(_ value: Bool) {
        FeatureFlagClientImpl.shared.providerJoinsMidExercise = value
    }
}

struct SettingsView: View {
    
    let viewModel: SettingsViewViewModel
    init(viewModel: SettingsViewViewModel) {
        self.viewModel = viewModel
        self.startTaskWithProviderOnline = viewModel.startTaskWithProviderOnline
        self.providerJoinsMidExercise = viewModel.providerJoinsMidExercise
    }
    
    @State var startTaskWithProviderOnline: Bool
    @State var providerJoinsMidExercise: Bool
    
    var body: some View {
        Form {
            Section("Settings") {
                Toggle("Start Task With Provider Online", isOn: $startTaskWithProviderOnline)
                Toggle("Provider Joins Mid Exercise", isOn: $providerJoinsMidExercise)
            }
        }
        .onChange(of: startTaskWithProviderOnline) {
            viewModel.setStartTaskWithProviderOnline(startTaskWithProviderOnline)
        }
        .onChange(of: providerJoinsMidExercise) {
            viewModel.setProvderJoinsMidExercise(providerJoinsMidExercise)
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewViewModel())
}
