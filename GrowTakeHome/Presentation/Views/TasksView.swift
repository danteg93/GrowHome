//
//  TasksView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct TasksView: View {
    
    @ObservedObject var navigationState: NavigationState
    
    init(navigationState: NavigationState) {
        self.navigationState = navigationState
    }
    
    var models: [TaskRowViewModel] = [
        TaskRowViewModel(style: .active, displayText: "October"),
        TaskRowViewModel(style: .complete, displayText: "Why"),
        TaskRowViewModel(style: .locked, displayText: "December")
    ]
    
    func didTap(model: TaskRowViewModel) {
        switch model.style {
        case .locked:
            return
        case .active:
            self.navigationState.push(model)
        case .complete:
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
    TasksView(navigationState: NavigationState())
}
