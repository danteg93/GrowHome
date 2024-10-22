//
//  TasksView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct TasksView: View {
    
    @ObservedObject var navigationState: NavigationState
    @StateObject var viewModel: TasksViewViewModel = TasksViewViewModel()

    init(navigationState: NavigationState) {
        self.navigationState = navigationState
    }
    
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
                Text(TasksLocalizedStrings.myTasks)
                    .font(.grow(.header700(.regular)))
                List(viewModel.models) { model in
                    TaskRow(viewModel: model) {
                        didTap(model: model)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadTasks()
        }
    }
}

#Preview {
    TasksView(navigationState: NavigationState())
}
