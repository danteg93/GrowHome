//
//  ContentView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var navigationState = NavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.path) {
            ZStack {
                TasksView(navigationState: navigationState)
            }
            .navigationDestination(for: BreatheViewModel.self) { model in
                BreatheView(viewModel: model, navigationState: navigationState)
            }
        }
    }
}

#Preview {
    ContentView()
}
