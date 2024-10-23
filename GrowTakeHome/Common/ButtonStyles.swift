//
//  ButtonStyles.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import SwiftUI

struct CTAButtonStyleGreen: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.grow(.text400(.regular)))
            .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
            .foregroundColor(.colorActionButton)
            .background(.colorNeutralGreen)
            .cornerRadius(12)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

struct CTAButtonStyleGreenLarge: ButtonStyle {
    
    var disabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(minWidth: 0,
                   maxWidth: .infinity)
            .font(.grow(.text400(.regular)))
            .foregroundColor(disabled ? .colorLabelsTertiary : .colorActionButton)
            .background(disabled ? .colorFillTertiary : .colorNeutralGreen)
            .cornerRadius(12)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

struct CTAButtonStyleBlack: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.grow(.text400(.regular)))
            .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
            .foregroundColor(.colorNeutralWhite)
            .background(.colorNeutralBlack)
            .cornerRadius(12)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}
