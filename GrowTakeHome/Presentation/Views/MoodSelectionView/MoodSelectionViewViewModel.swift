//
//  MoodSelectionViewViewModel.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/23/24.
//

import Foundation

class MoodSelectionViewViewModel: ObservableObject {
    
    let taskEntityId: UUID
    @Published var moodSelections: [String] = []
    
    private let tasksClient: any TasksClient
    
    init(taskEntityId: UUID,
         tasksClient: any TasksClient = TasksClientImpl.shared) {
        self.taskEntityId = taskEntityId
        self.tasksClient = tasksClient
        self.fetchMoodChoices()
    }
    
    private func fetchMoodChoices() {
        Task {
            do {
                let taskEntity = try await tasksClient.fetchTask(id: taskEntityId)
                if let moodChoices = taskEntity.moodChoices {
                    self.moodSelections = moodChoices
                }
            } catch {
                // TODO: Fail
            }
        }
    }
    
    @MainActor
    func selectMood(mood: String, with navigationState: NavigationState) {
        Task {
            do {
                try await tasksClient.setTaskMood(id: taskEntityId, selectedMood: mood)
                navigationState.empty()
            } catch {
                return
            }
        }
    }
}

extension MoodSelectionViewViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(taskEntityId)
    }
    
    static func == (lhs: MoodSelectionViewViewModel, rhs: MoodSelectionViewViewModel) -> Bool {
        return lhs.taskEntityId == rhs.taskEntityId
    }
}
