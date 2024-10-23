//
//  TasksView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct TasksView: View {
    
    enum Constants {
        static let topTitleVerticalSpacing: CGFloat = 46
        static let topTitleListVerticalSpacing: CGFloat = 28
        static let verticalListSpacing: CGFloat = 8
        static let horizontalListSpacing: CGFloat = 32
        static let rowSpacing: CGFloat = 16
    }
    
    @ObservedObject var navigationState: NavigationState
    @StateObject var viewModel: TasksViewViewModel = TasksViewViewModel()

    init(navigationState: NavigationState) {
        self.navigationState = navigationState
    }
    
    func didTap(model: TaskRowViewModel) {
        viewModel.navigateToNextView(for: model, with: navigationState)
    }
    
    var body: some View {
        ZStack {
            Color.colorBackgroundPrimary
                .ignoresSafeArea()
            SettingsButtonView {
                viewModel.navigateToSettings(with: navigationState)
            }
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: Constants.topTitleVerticalSpacing)
                Text(TasksLocalizedStrings.myTasks)
                    .font(.grow(.header700(.regular)))
                    .padding(.horizontal, Constants.horizontalListSpacing)
                Spacer()
                    .frame(height: Constants.topTitleListVerticalSpacing)
                List(viewModel.models) { model in
                    TaskRow(viewModel: model) {
                        didTap(model: model)
                    }
                    .listRowInsets(EdgeInsets(
                        top: Constants.verticalListSpacing,
                        leading: Constants.horizontalListSpacing,
                        bottom: Constants.verticalListSpacing,
                        trailing: Constants.horizontalListSpacing))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listRowSpacing(0)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                Spacer()
            }
        }
        .onAppear {
            viewModel.loadTasks()
        }
    }
}

struct SettingsButtonView: View {
    var onTap: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    onTap?()
                } label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorNeutralBlack)
                }
                .padding(.horizontal, 32)
            }
            Spacer()
        }
    }
}

#Preview {
    TasksView(navigationState: NavigationState())
}
