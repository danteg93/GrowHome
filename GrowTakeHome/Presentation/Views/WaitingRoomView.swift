//
//  WaitingRoomView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import SwiftUI

struct WaitingRoomViewViewModel: Hashable {
    let taskEntityId: UUID
    
    init(taskEntityId: UUID) {
        self.taskEntityId = taskEntityId
    }
    
    func waitForProvider(with navigationState: NavigationState) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let liveSessionViewViewModel = LiveSessionViewViewModel(taskEntityId: taskEntityId)
            navigationState.push(liveSessionViewViewModel)
        }
    }
}

struct WaitingRoomView: View {
    
    enum Constants {
        static let verticalSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
    }
    
    let viewModel: WaitingRoomViewViewModel
    @ObservedObject var navigationState: NavigationState
    @State var initialLoad = true
    
    init(viewModel: WaitingRoomViewViewModel, navigationState: NavigationState) {
        self.viewModel = viewModel
        self.navigationState = navigationState
    }
    
    var body: some View {
        ZStack {
            Color.colorNeutralGreen
                .ignoresSafeArea()
            VStack(spacing: Constants.verticalSpacing) {
                Text(SessionLocalizedStrings.waitingForProvider)
                    .font(.grow(.text400(.large)))
                Text(SessionLocalizedStrings.waitingRoomDescriptionMessage)
                    .font(.grow(.text400(.regular)))
                    .multilineTextAlignment(.center)
                
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
        .onAppear {
            guard initialLoad else { return }
            initialLoad = false
            viewModel.waitForProvider(with: navigationState)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WaitingRoomView(viewModel: WaitingRoomViewViewModel(taskEntityId: UUID()),
                    navigationState: NavigationState())
}
