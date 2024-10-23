//
//  LiveSessionView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import SwiftUI

struct LiveSessionViewViewModel {
    let taskEntityId: UUID
    
    private let tasksClient: any TasksClient
    
    init(taskEntityId: UUID,
         tasksClient: any TasksClient = TasksClientImpl.shared) {
        self.taskEntityId = taskEntityId
        self.tasksClient = tasksClient
    }
    
    @MainActor
    func endSession(with navigationState: NavigationState) {
        Task {
            do {
                try await tasksClient.completeTask(id: taskEntityId, completed: true)
                let moodSelectionViewViewModel = MoodSelectionViewViewModel(taskEntityId: taskEntityId)
                navigationState.push(moodSelectionViewViewModel)
            } catch {
                return
            }
        }
    }
}

extension LiveSessionViewViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(taskEntityId)
    }
    
    static func == (lhs: LiveSessionViewViewModel, rhs: LiveSessionViewViewModel) -> Bool {
        return lhs.taskEntityId == rhs.taskEntityId
    }
}

struct LiveSessionView: View {
    
    enum Constants {
        static let verticalSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 90
    }
    
    let viewModel: LiveSessionViewViewModel
    @ObservedObject var navigationState: NavigationState
    
    init(viewModel: LiveSessionViewViewModel,
         navigationState: NavigationState) {
        self.viewModel = viewModel
        self.navigationState = navigationState
    }
    
    var body: some View {
        ZStack {
            Color.colorNeutralGreen
                .ignoresSafeArea()
            VStack(spacing: Constants.verticalSpacing) {
                Text(SessionLocalizedStrings.inSession)
                    .font(.grow(.text400(.large)))
                    .multilineTextAlignment(.center)
                Button(SessionLocalizedStrings.exit, action: {
                    viewModel.endSession(with: navigationState)
                })
                    .buttonStyle(CTAButtonStyleBlack())
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LiveSessionView(viewModel: LiveSessionViewViewModel(taskEntityId: UUID()), navigationState: NavigationState())
}
