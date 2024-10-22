//
//  TasksView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct TasksView: View {
    
    var models: [TaskRowViewModel] = [
        TaskRowViewModel(style: .active, displayText: "October"),
        TaskRowViewModel(style: .completed, displayText: "Why"),
        TaskRowViewModel(style: .locked, displayText: "December")
    ]
    
    func didTap(model: TaskRowViewModel) {
        switch model.style {
        case .locked:
            return
        case .active:
            return
            //self.path.append(model)
        case .completed:
            return
        }
    }
    
    var body: some View {
        ZStack {
            Color.colorBackgroundPrimary
                .ignoresSafeArea()
            VStack {
                Text("My Tasks")
                    .font(.grow(.header700(.regular)))
                List(models) { model in
                    TaskRow(viewModel: model) {
                        didTap(model: model)
                    }
                }
            }
        }
    }
}

#Preview {
    TasksView()
}
