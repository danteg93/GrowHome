//
//  TaskRow.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct TaskRowConfiguration {
    let spacingInsets: EdgeInsets
    let textFont: Font
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color
    let iconFrameSize: CGSize
    
    static var `default`: TaskRowConfiguration {
        TaskRowConfiguration(
            spacingInsets: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
            textFont: .grow(.text400(.regular)),
            cornerRadius: 10,
            borderWidth: 1,
            borderColor: .colorNeutralBlack,
            iconFrameSize: CGSize(width: 17, height: 17))
    }
}

class TaskRowViewModel: ObservableObject, Identifiable {
    enum ViewStyle {
        case locked
        case active
        case complete
    }
    
    @Published var style: ViewStyle
    @Published var displayText: String
    let displayTextColor: Color
    let icon: Image?
    let iconColor: Color?
    let backgroundColor: Color
    
    
    init(style: ViewStyle, displayText: String) {
        self.style = style
        self.displayText = displayText
        switch style {
        case .locked:
            self.displayTextColor = .colorNeutralBlack
            self.icon = Image(systemName: "lock")
            self.iconColor = .colorNeutralGray
            self.backgroundColor = .colorBackgroundPrimary
        case .active:
            self.displayTextColor = .colorNeutralBlack
            self.icon = Image(systemName: "chevron.right")
            self.iconColor = .colorNeutralBlack
            self.backgroundColor = .colorNeutralGreen
        case .complete:
            self.displayTextColor = .colorNeutralGray
            self.icon = Image(systemName: "checkmark.seal.fill")
            self.iconColor = .colorBackgroundSecondary
            self.backgroundColor = .colorBackgroundPrimary
        }
    }
}

extension TaskRowViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TaskRowViewModel, rhs: TaskRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct TaskRow: View {
    
    let configuration: TaskRowConfiguration
    @ObservedObject var viewModel: TaskRowViewModel
    
    var didTap: (() -> Void)?
    
    init(configuration: TaskRowConfiguration = .default,
         viewModel: TaskRowViewModel,
         didTap: (() -> Void)? = nil) {
        self.configuration = configuration
        self.viewModel = viewModel
        self.didTap = didTap
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text(viewModel.displayText)
                    .font(configuration.textFont)
                    .foregroundStyle(viewModel.displayTextColor)
                Spacer()
                if let icon = viewModel.icon,
                   let iconColor = viewModel.iconColor {
                    icon
                        .foregroundColor(iconColor)
                        .frame(
                            width: configuration.iconFrameSize.width,
                            height: configuration.iconFrameSize.height
                        )
                }
            }
        }
        .padding(configuration.spacingInsets)
        .background(viewModel.backgroundColor)
        .cornerRadius(configuration.cornerRadius)
        .gesture(
            TapGesture()
                .onEnded({ _ in
                    self.didTap?()
                })
        )
        .overlay(
            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                .stroke(configuration.borderColor, lineWidth: configuration.borderWidth)
        )
    }
}

#Preview {
    TaskRow(viewModel: TaskRowViewModel(style: .active, displayText: "November"))
}
