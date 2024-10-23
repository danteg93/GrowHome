//
//  TasksClient.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation


protocol TasksClient {
    func fetchTasks() async throws -> TasksEntity
}

actor TasksClientImpl: TasksClient {
    
    static let shared = TasksClientImpl()
    private init() { }
    
    enum TasksClientError: Error {
        case couldNotFetchTasks
    }
    
    private var cachedTasks: [TaskEntity] = []
    
    func fetchTasks() throws -> TasksEntity {
        if !cachedTasks.isEmpty {
            return TasksEntity(tasks: cachedTasks)
        } else {
            if let data = try? JSONDataSource.load(fileName: "tasks.json"),
               let tasks = try? JSONDecoder().decode(TasksEntity.self, from: data) {
                self.cachedTasks = tasks.tasks
                return tasks
            } else {
                throw TasksClientError.couldNotFetchTasks
            }
        }
    }
    
    func completeTask(id: UUID, completed: Bool = true) {
        guard let index = cachedTasks.firstIndex(where: {$0.id == id}) else { return }
        if cachedTasks.indices.contains(index) {
            cachedTasks[index].completed = completed
            cachedTasks[index].completedDate = Date()
        }
    }
}
