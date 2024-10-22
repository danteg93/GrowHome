//
//  TasksView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct TasksView: View {
    
    @ObservedObject var navigationState: NavigationState
    // Maybe move to VM
    @State private var firstTime: Bool = true
    
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
        .onAppear {
            loadFile()
        }
    }
    
    // TODO: Move to VM
    
    func loadFile() {
        guard firstTime else { return }
        firstTime = false
        if let data = try? JSONDataSource.load(fileName: "tasks.json"),
           
           let tasks = try? JSONDecoder().decode(TasksEntity.self, from: data) {
            print("\(tasks.tasks.first)")
        } else {
            print("failure baby")
        }
    }
}

#Preview {
    TasksView(navigationState: NavigationState())
}
