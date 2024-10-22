//
//  TasksView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

class TasksViewViewModel: ObservableObject {
    
    private let tasksClient: any TasksClient
    
    @Published private(set) var models: [TaskRowViewModel] = []
    private var initialLoad = true
    
    init(tasksClient: any TasksClient = TasksClientImpl()) {
        self.tasksClient = tasksClient
    }
    
    func loadTasks() {
        do {
            guard initialLoad else { return }
            self.initialLoad = false
            let tasks = try tasksClient.fetchTasks()
            let models = tasks.tasks.compactMap { TaskRowViewModel.from($0, active: true) }
            self.models = models
        } catch {
            // TODO: Fail
        }
        
    }
}

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
