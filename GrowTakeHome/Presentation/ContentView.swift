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
            .navigationDestination(for: TaskRowViewModel.self) { model in
                BreatheView(viewModel: BreatheViewModel(name: model.displayText, taskId: model.taskEntityId))
            }
        }
    }
}

#Preview {
    ContentView()
}
