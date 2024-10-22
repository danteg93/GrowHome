//
//  ContentView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct ContentView: View {
    
    var models: [TaskRowViewModel] = [
        TaskRowViewModel(style: .active, displayText: "October"),
        TaskRowViewModel(style: .completed, displayText: "Why"),
        TaskRowViewModel(style: .locked, displayText: "December")
    ]
    
    @State private var path = NavigationPath()
    
    func didTap(model: TaskRowViewModel) {
        switch model.style {
        case .locked:
            return
        case .active:
            self.path.append(model)
        case .completed:
            return
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
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
            .navigationDestination(for: TaskRowViewModel.self) { model in
                Text("Oh Snap \(model.displayText)")
                    .font(.largeTitle.bold())
                    //.navigationBarBackButtonHidden()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
