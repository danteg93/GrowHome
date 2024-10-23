//
//  BreatheViewViewModel.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

class BreatheViewViewModel: ObservableObject {
    
    private let featureFlagClient: any FeatureFlagClient
    
    @Published var providerHasJoined = false
    let breathCount: Int
    let taskEntityId: UUID
    
    init(breathCount: Int,
         taskEntityId: UUID,
         featureFlagClient: any FeatureFlagClient = FeatureFlagClientImpl.shared) {
        self.breathCount = breathCount
        self.taskEntityId = taskEntityId
        self.featureFlagClient = featureFlagClient
        self.waitForProvider()
    }
    
    func waitForProvider() {
        guard self.featureFlagClient.providerJoinsMidExercise else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.providerHasJoined = true
        }
    }
    
    @MainActor
    func navigateToNextView(startSession: Bool, with navigationState: NavigationState) {
        if startSession {
            let liveSessionViewViewModel = LiveSessionViewViewModel(taskEntityId: taskEntityId)
            navigationState.push(liveSessionViewViewModel)
        } else if providerHasJoined {
            let joinSessionViewViewModel = JoinSessionViewViewModel(taskEntityId: taskEntityId)
            navigationState.push(joinSessionViewViewModel)
        } else {
            let waitingRoomViewViewModel = WaitingRoomViewViewModel(taskEntityId: taskEntityId)
            navigationState.push(waitingRoomViewViewModel)
        }
    }
}

extension BreatheViewViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(taskEntityId)
    }
    
    static func == (lhs: BreatheViewViewModel, rhs: BreatheViewViewModel) -> Bool {
        return lhs.taskEntityId == rhs.taskEntityId
    }
}
