//
//  MoodSelectionView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/23/24.
//

import SwiftUI

struct MoodSelectionView: View {
    
    enum Constants {
        static let topTitleVerticalSpacing: CGFloat = 156
        static let topTitleListVerticalSpacing: CGFloat = 72
        static let verticalListSpacing: CGFloat = 8
        static let horizontalListSpacing: CGFloat = 51
        static let buttonTopSpacing: CGFloat = 24
    }
    
    let viewModel: MoodSelectionViewViewModel
    @ObservedObject var navigationState: NavigationState
    @State var selectedMood: String? = nil
    
    init(viewModel: MoodSelectionViewViewModel,
         navigationState: NavigationState) {
        self.viewModel = viewModel
        self.navigationState = navigationState
    }
    
    var body: some View {
        ZStack {
            Color.colorBackgroundPrimary
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: Constants.topTitleVerticalSpacing)
                Text(SessionLocalizedStrings.howHaveYouBeenWeek)
                    .font(.grow(.header700(.regular)))
                    .foregroundStyle(.colorNeutralBlack)
                    .padding(.horizontal, Constants.horizontalListSpacing)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: Constants.topTitleListVerticalSpacing)
                List {
                    ForEach(viewModel.moodSelections, id: \.self) { mood in
                        MoodRow(viewModel: .init(mood: mood), selectedMood: $selectedMood)
                    }
                    .listRowInsets(EdgeInsets(
                        top: Constants.verticalListSpacing,
                        leading: Constants.horizontalListSpacing,
                        bottom: Constants.verticalListSpacing,
                        trailing: Constants.horizontalListSpacing))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    Button(SessionLocalizedStrings.logActivity, action: {
                        if let selectedMood = selectedMood {
                            viewModel.selectMood(mood: selectedMood, with: navigationState)
                        }
                    })
                    .buttonStyle(CTAButtonStyleGreenLarge(disabled: selectedMood == nil))
                    .listRowInsets(EdgeInsets(
                        top: Constants.buttonTopSpacing,
                        leading: Constants.horizontalListSpacing,
                        bottom: Constants.verticalListSpacing,
                        trailing: Constants.horizontalListSpacing))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .disabled(selectedMood == nil)
                }
                .listRowSpacing(0)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    MoodSelectionView(viewModel: MoodSelectionViewViewModel(taskEntityId: UUID()),
                      navigationState: NavigationState())
}
