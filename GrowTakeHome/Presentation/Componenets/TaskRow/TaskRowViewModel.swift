//
//  TaskRowViewModel.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import SwiftUI

class TaskRowViewModel: ObservableObject, Identifiable {
    enum ViewStyle {
        case locked
        case active
        case complete
    }
    
    @Published var style: ViewStyle {
        didSet {
            self.updateStyle()
        }
    }
    @Published var displayText: String
    @Published var displayTextColor: Color
    @Published var icon: Image?
    @Published var iconColor: Color?
    @Published var backgroundColor: Color
    
    let taskEntityId: UUID
    
    init(style: ViewStyle, displayText: String, taskEntityId: UUID) {
        self.style = style
        self.displayText = displayText
        self.displayTextColor = .colorNeutralGray
        self.icon = Image(systemName: "lock")
        self.iconColor = .colorNeutralGray
        self.backgroundColor = .colorBackgroundPrimary
        self.taskEntityId = taskEntityId
        self.updateStyle()
    }
    
    private func updateStyle() {
        switch self.style {
        case .locked:
            self.displayTextColor = .colorNeutralGray
            self.icon = Image(systemName: "lock")
            self.iconColor = .colorNeutralGray
            self.backgroundColor = .colorBackgroundPrimary
        case .active:
            self.displayTextColor = .colorNeutralBlack
            self.icon = Image(systemName: "chevron.right")
            self.iconColor = .colorNeutralBlack
            self.backgroundColor = .colorNeutralGreen
        case .complete:
            self.displayTextColor = .colorNeutralBlack
            self.icon = Image(systemName: "checkmark.seal.fill")
            self.iconColor = .colorBackgroundSecondary
            self.backgroundColor = .colorBackgroundPrimary
        }
    }
}

extension TaskRowViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TaskRowViewModel, rhs: TaskRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension TaskRowViewModel {
    static func from(_ taskEntity: TaskEntity, active: Bool) -> TaskRowViewModel? {
        
        guard let dueDate = taskEntity.dueDate else {
            return nil
        }
        
        var style: ViewStyle = .locked
        var displayText = dueDate.formattedDescription
        
        if taskEntity.completed {
            style = .complete
            
            var textPrefix: String
            if let selectedMood = taskEntity.selectedMood {
                textPrefix = selectedMood.capitalized
            } else {
                textPrefix = TasksLocalizedStrings.completed
            }
            
            var textSuffix: String
            if let completedDate = taskEntity.completedDate {
                textSuffix = completedDate.formattedDescription
            } else {
                textSuffix = dueDate.formattedDescription
            }
            
            displayText = "\(textPrefix) (\(textSuffix))"
           
        } else if Date() > dueDate && active  {
            style = .active
        }
                
        return TaskRowViewModel(style: style, displayText: displayText, taskEntityId: taskEntity.id)
    }
}
