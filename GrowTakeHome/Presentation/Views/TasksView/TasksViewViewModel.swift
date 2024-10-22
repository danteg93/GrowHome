//
//  TasksViewViewModel.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

class TasksViewViewModel: ObservableObject {
    
    private let tasksClient: any TasksClient
    
    @Published private(set) var models: [TaskRowViewModel] = []
    private var initialLoad = true
    
    init(tasksClient: any TasksClient = TasksClientImpl()) {
        self.tasksClient = tasksClient
    }
    
    func loadTasks() {
        do {
            guard initialLoad else { return }
            self.initialLoad = false
            // Sort Tasks by date
            let sortedTasks = try tasksClient.fetchTasks().tasks.sorted {
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
