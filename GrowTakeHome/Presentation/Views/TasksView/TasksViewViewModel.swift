//
//  TasksViewViewModel.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

class TasksViewViewModel: ObservableObject {
    
    private let tasksClient: any TasksClient
    private let featureFlagClient: any FeatureFlagClient
    
    @Published private(set) var models: [TaskRowViewModel] = []
    private var initialLoad = true
    
    init(tasksClient: any TasksClient = TasksClientImpl.shared,
         featureFlagClient: any FeatureFlagClient = FeatureFlagClientImpl.shared) {
        self.tasksClient = tasksClient
        self.featureFlagClient = featureFlagClient
    }
    
    @MainActor
    func loadTasks() {
        Task {
            do {
                // Sort Tasks by date
                let sortedTasks = try await tasksClient.fetchTasks().tasks.sorted {
                    $0.dueDate ?? Date() > $1.dueDate ?? Date()
                }
                // Find the active task
                // This loops through all tasks and finds the first task that is not completed
                // and that is not in the future
                var activeId: UUID?
                for task in sortedTasks {
                    if activeId != nil { break }
                    if let dueDate = task.dueDate,
                       dueDate <= Date(),
                       task.completed == false {
                        activeId = task.id
                    }
                }
                let models = sortedTasks.compactMap { TaskRowViewModel.from($0, active: $0.id == activeId) }
                self.models = models
            } catch {
                // TODO: Fail
            }
        }
    }
    
    @MainActor
    func determineNextView(for model: TaskRowViewModel, with navigationState: NavigationState) {
        guard case .active = model.style else {
            return
        }
        Task {
            do {
                let taskEntity = try await tasksClient.fetchTask(id: model.taskEntityId)
                if featureFlagClient.startTaskWithProviderOnline {
                    let joinSessionViewViewModel = JoinSessionViewViewModel(taskEntityId: taskEntity.id)
                    navigationState.push(joinSessionViewViewModel)
                } else {
                    let breatheViewViewModel = BreatheViewViewModel(breathCount: taskEntity.breathCount ?? 0,
                                                                    taskEntityId: taskEntity.id)
                    navigationState.push(breatheViewViewModel)
                }
            } catch {
                return
            }
        }
    }
}
