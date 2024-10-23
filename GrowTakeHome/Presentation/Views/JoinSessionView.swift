//
//  JoinSessionView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import SwiftUI

struct JoinSessionViewViewModel: Hashable {
    let taskEntityId: UUID
    
    func navigateToNextView(with navigationState: NavigationState) {
        let liveSessionViewViewModel = LiveSessionViewViewModel(taskEntityId: taskEntityId)
        navigationState.push(liveSessionViewViewModel)
    }
}

struct JoinSessionView: View {
    
    enum Constants {
        static let verticalSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 90
    }
    
    let viewModel: JoinSessionViewViewModel
    @ObservedObject var navigationState: NavigationState
    
    init(viewModel: JoinSessionViewViewModel,
         navigationState: NavigationState) {
        self.viewModel = viewModel
        self.navigationState = navigationState
    }
    
    var body: some View {
        ZStack {
            Color.colorBackgroundSecondary
                .ignoresSafeArea()
            VStack(spacing: Constants.verticalSpacing) {
                Text(SessionLocalizedStrings.providerInSession)
                    .font(.grow(.text400(.large)))
                    .multilineTextAlignment(.center)
                Button(SessionLocalizedStrings.joinNow, action: {
                    viewModel.navigateToNextView(with: navigationState)
                })
                    .buttonStyle(CTAButtonStyleGreen())
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
    }
}

#Preview {
    JoinSessionView(viewModel: JoinSessionViewViewModel(taskEntityId: UUID()), navigationState: NavigationState())
}
