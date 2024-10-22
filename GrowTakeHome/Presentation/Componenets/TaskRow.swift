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
    
    static var `default`: TaskRowConfiguration {
        TaskRowConfiguration(
            spacingInsets: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
            textFont: .grow(.text400(.regular)),
            cornerRadius: 10,
            borderWidth: 1)
    }
}

struct TaskRow: View {
    
    let configuration: TaskRowConfiguration
    
    init(configuration: TaskRowConfiguration = .default) {
        self.configuration = configuration
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text("October")
                    .font(configuration.textFont)
                Spacer()
                Image(systemName: "lock")
            }
        }
        .padding(configuration.spacingInsets)
        .background(.colorBackgroundSecondary)
        .cornerRadius(configuration.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                .stroke(.colorNeutralBlack, lineWidth: configuration.borderWidth)
        )
    }
}

#Preview {
    TaskRow()
}
