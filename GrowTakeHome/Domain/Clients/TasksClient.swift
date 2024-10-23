//
//  TasksClient.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

// MARK: Client Protocol
protocol TasksClient {
    func fetchTasks() async throws -> TasksEntity
    func fetchTask(id: UUID) async throws -> TaskEntity
    func completeTask(id: UUID, completed: Bool) async throws
    func setTaskMood(id: UUID, selectedMood: String) async throws
}
// MARK: Client Implementation
actor TasksClientImpl: TasksClient {
    
    static let shared = TasksClientImpl()
    private init() { }
    
    enum TasksClientError: Error {
        case couldNotFetchTasks
        case taskWithIdNotFound
    }
    
    private var cachedTasks: [TaskEntity] = []
    
    /// Fetches a TasksEntity from cache if available. Otherwise, it will fetch from the "tasks.json" file
    /// - Returns: a TasksEntity containing the fetched tasks
    @discardableResult
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
    
    /// Fetches a TasksEntity from cache if available. Otherwise, it will fetch from the "tasks.json" file, build the cache
    /// and attempt to find the entity with the given id
    /// - Parameters: a UUID object that helps identify the TaskEntity
    /// - Returns: a TaskEntity matching the UUID give, if available.
    func fetchTask(id: UUID) throws -> TaskEntity {
        if cachedTasks.isEmpty {
            try self.fetchTasks()
        }
        guard let index = cachedTasks.firstIndex(where: {$0.id == id}),
              cachedTasks.indices.contains(index) else {
            throw TasksClientError.taskWithIdNotFound
        }
        return cachedTasks[index]
    }
    
    func completeTask(id: UUID, completed: Bool = true) throws {
        guard let index = cachedTasks.firstIndex(where: {$0.id == id}),
              cachedTasks.indices.contains(index) else {
            throw TasksClientError.taskWithIdNotFound
        }
        cachedTasks[index].completed = completed
    }
    
    func setTaskMood(id: UUID, selectedMood: String) throws {
        guard let index = cachedTasks.firstIndex(where: {$0.id == id}),
              cachedTasks.indices.contains(index) else {
            throw TasksClientError.taskWithIdNotFound
        }
        cachedTasks[index].selectedMood = selectedMood
    }
}
