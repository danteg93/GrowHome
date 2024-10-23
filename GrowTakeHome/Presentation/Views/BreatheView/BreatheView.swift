//
//  BreatheView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct BreatheViewModel {
    let name: String
    let taskId: UUID
    
    func completeTask() async {
        try? await TasksClientImpl.shared.completeTask(id: taskId)
    }
}

struct BreatheView: View {
    
    let viewModel: BreatheViewModel
    @State var completedTask = false
    
    init(viewModel: BreatheViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(viewModel.name)
            .font(.largeTitle.bold())
            .onAppear {
                if !completedTask {
                    completedTask = true
                    Task {
                        await viewModel.completeTask()
                    }
                }
            }
    }
}

#Preview {
    BreatheView(viewModel: .init(name: "WoW", taskId: UUID()))
}
