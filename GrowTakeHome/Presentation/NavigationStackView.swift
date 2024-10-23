//
//  NavigationStackView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct NavigationStackView: View {
    
    @StateObject var navigationState = NavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.path) {
            ZStack {
                TasksView(navigationState: navigationState)
            }
            .navigationDestination(for: BreatheViewViewModel.self) { model in
                BreatheView(viewModel: model, navigationState: navigationState)
            }
            .navigationDestination(for: JoinSessionViewViewModel.self) { model in
                JoinSessionView(viewModel: model, navigationState: navigationState)
            }
            .navigationDestination(for: LiveSessionViewViewModel.self) { model in
                LiveSessionView(viewModel: model, navigationState: navigationState)
            }
            .navigationDestination(for: WaitingRoomViewViewModel.self) { model in
                WaitingRoomView(viewModel: model, navigationState: navigationState)
            }
            .navigationDestination(for: SettingsViewViewModel.self) { model in
                SettingsView(viewModel: model)
            }
            .navigationDestination(for: MoodSelectionViewViewModel.self) { model in
                MoodSelectionView(viewModel: model, navigationState: navigationState)
            }
        }
    }
}

#Preview {
    NavigationStackView()
}
