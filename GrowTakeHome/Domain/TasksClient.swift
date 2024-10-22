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
// TODO: Explore
//@globalActor struct TasksCacheActor {
//    static var shared = TasksCache()
//}
//
//actor TasksCache {
//    
//    private var cachedTasks: TasksEntity?
//    
//    func getData() -> TasksEntity? {
//        return cachedTasks
//    }
//    
//    func setData(_ tasksEntity: TasksEntity?) {
//        self.cachedTasks = tasksEntity
//    }
//}
//
//
//protocol TasksClient {
//    func fetchTasks() async throws -> TasksEntity
//}
//
//class TasksClientImpl: TasksClient {
//
//    enum TasksClientError: Error {
//        case couldNotFetchTasks
//    }
//    
//    private let cache: TasksCache
//    
//    init(cache: TasksCache = TasksCacheActor.shared) {
//        self.cache = cache
//    }
//    
//    
//    @TasksCacheActor
//    func fetchTasks() async throws -> TasksEntity {
//        if let cachedEntity = await cache.getData() {
//            return cachedEntity
//        } else {
//            if let data = try? JSONDataSource.load(fileName: "tasks.json"),
//               let tasks = try? JSONDecoder().decode(TasksEntity.self, from: data) {
//                await self.cache.setData(tasks)
//                return tasks
//            } else {
//                throw TasksClientError.couldNotFetchTasks
//            }
//        }
//    }    
//}
