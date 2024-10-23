//
//  MoodRow.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/23/24.
//

import SwiftUI

struct MoodRowConfiguration {
    let spacingInsets: EdgeInsets
    let backgroundColor: Color
    let backgroundSelectedColor: Color
    let textFont: Font
    let textColor: Color
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color
    let selectionIcon: Image
    let iconFrameSize: CGSize
    
    static var `default`: MoodRowConfiguration {
        MoodRowConfiguration(
            spacingInsets: EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 16),
            backgroundColor: .colorBackgroundPrimary,
            backgroundSelectedColor: .colorBackgroundSecondary,
            textFont: .grow(.text400(.regular)),
            textColor: .colorNeutralBlack,
            cornerRadius: 10,
            borderWidth: 1,
            borderColor: .colorNeutralBlack,
            selectionIcon: Image(systemName: "checkmark.circle.fill"),
            iconFrameSize: CGSize(width: 17, height: 17))
    }
}

struct MoodRowViewModel {
    let mood: String
}

struct MoodRow: View {
    
    let configuration: MoodRowConfiguration
    let viewModel: MoodRowViewModel
    @Binding var selectedMood: String?
    
    private var isSelected: Bool {
        viewModel.mood == selectedMood
    }

    init(configuration: MoodRowConfiguration = .default,
         viewModel: MoodRowViewModel,
         selectedMood: Binding<String?>) {
        self.configuration = configuration
        self.viewModel = viewModel
        self._selectedMood = selectedMood
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text(viewModel.mood)
                    .font(configuration.textFont)
                    .foregroundStyle(configuration.textColor)
                Spacer()
                if isSelected {
                    configuration.selectionIcon
                        .foregroundColor(configuration.textColor)
                }
            }
        }
        .padding(configuration.spacingInsets)
        .background( self.isSelected ? .colorBackgroundSecondary : .colorBackgroundPrimary)
        .cornerRadius(configuration.cornerRadius)
        .gesture(
            TapGesture()
                .onEnded({ _ in
                    self.selectedMood = self.viewModel.mood
                })
        )
        .overlay(
            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                .stroke(configuration.borderColor, lineWidth: configuration.borderWidth)
        )
    }
}

#Preview {
    struct Preview: View {
        @State var selectedMood: String?
        var body: some View {
            MoodRow(viewModel: .init(mood: "Sad"), selectedMood: $selectedMood)
        }
    }
    return Preview()
 
}
