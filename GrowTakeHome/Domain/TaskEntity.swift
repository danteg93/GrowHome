//
//  TasksEntity.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

struct TasksEntity: Codable {
    var tasks: [TaskEntity]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer().decode([TaskEntity].self)
        self.tasks = container
    }
}

struct TaskEntity: Codable {
    
    let breathCount: Int?
    let moodChoices: [String]?
    let dueDate: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer().decode([TaskContentType].self)
        var breathCount: Int?
        var moodChoices: [String]?
        var dueDate: String?
        
        for contentType in container {
            switch contentType {
            case .breathCount(let int):
                breathCount = int
            case .moodChoices(let array):
                moodChoices = array
            case .dueDate(let string):
                dueDate = string
            }
        }
        self.breathCount = breathCount
        self.moodChoices = moodChoices
        self.dueDate = dueDate
    }
}

enum TaskContentType: Codable {
    case breathCount(Int)
    case moodChoices([String])
    case dueDate(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
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


