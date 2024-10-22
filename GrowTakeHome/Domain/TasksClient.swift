//
//  TasksClient.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation


protocol TasksClient {
    func fetchTasks() throws -> TasksEntity
}

class TasksClientImpl: TasksClient {

    enum TasksClientError: Error {
        case couldNotFetchTasks
    }
    
    private var cachedTasks: [TaskEntity]?
    
    func fetchTasks() throws -> TasksEntity {
        if let cachedTasks = cachedTasks {
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
}
