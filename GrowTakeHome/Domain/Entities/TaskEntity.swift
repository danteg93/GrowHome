//
//  TasksEntity.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation
// MARK: - TaskEntity
struct TaskEntity: Codable, Identifiable {
    
    enum Constants {
        static let dateFormat = "MM-dd-yyyy"
    }
    
    let id = UUID()
    let breathCount: Int?
    let moodChoices: [String]?
    let dueDate: Date?
    
    var completed: Bool = false
    var selectedMood: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer().decode([TaskContentType].self)
        var breathCount: Int?
        var moodChoices: [String]?
        var dueDate: Date?
        
        for contentType in container {
            switch contentType {
            case .breathCount(let int):
                breathCount = int
            case .moodChoices(let array):
                moodChoices = array
            case .dueDate(let string):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = Constants.dateFormat
                if let parsedDate = dateFormatter.date(from: string) {
                    dueDate = parsedDate
                }
                
            }
        }
        self.breathCount = breathCount
        self.moodChoices = moodChoices
        self.dueDate = dueDate
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        
        if let breathCount = breathCount {
            try container.encode(TaskContentType.breathCount(breathCount))
        }
        if let moodChoices = moodChoices {
            try container.encode(TaskContentType.moodChoices(moodChoices))
        }
        if let dueDate = dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Constants.dateFormat
            let dateString = dateFormatter.string(from: dueDate)
            try container.encode(TaskContentType.dueDate(dateString))
        }
    }
}
// MARK: - TaskContentType
enum TaskContentType: Codable {
    case breathCount(Int)
    case moodChoices([String])
    case dueDate(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        // The JSON object is an array of unknown types. However, they don't repeat types.
        // We go through all the values and attempt to cast them into the types we know they can be
        // This would break if all the sudden we have two elements of the same type. However, for the scope
        // of this project this will work.
        do {
            self = try .breathCount(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .moodChoices(container.decode([String].self))
            } catch DecodingError.typeMismatch {
                do {
                    self = try .dueDate(container.decode(String.self))
                } catch DecodingError.typeMismatch {
                    throw DecodingError.typeMismatch(TaskContentType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
                }
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .breathCount(let count):
            try container.encode(count)
        case .moodChoices(let choices):
            try container.encode(choices)
        case .dueDate(let date):
            try container.encode(date)
        }
    }
}
// MARK: - TasksEntity
struct TasksEntity: Codable {
    var tasks: [TaskEntity]
    
    init(tasks: [TaskEntity]) {
        self.tasks = tasks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer().decode([TaskEntity].self)
        self.tasks = container
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try tasks.forEach { try container.encode($0) }
    }
}

