//
//  TasksClient.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation


protocol TasksClient {
    func fetchTasks() async throws -> TasksEntity
    func fetchTask(id: UUID) async throws -> TaskEntity
    func completeTask(id: UUID, completed: Bool) async throws
}

actor TasksClientImpl: TasksClient {
    
    static let shared = TasksClientImpl()
    private init() { }
    
    enum TasksClientError: Error {
        case couldNotFetchTasks
        case taskWithIdNotFound
    }
    
    private var cachedTasks: [TaskEntity] = []
    
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
}
