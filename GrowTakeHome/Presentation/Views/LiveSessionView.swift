//
//  LiveSessionView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import SwiftUI

struct LiveSessionView: View {
    
    enum Constants {
        static let verticalSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 90
    }
    
    var body: some View {
        ZStack {
            Color.colorNeutralGreen
                .ignoresSafeArea()
            VStack(spacing: Constants.verticalSpacing) {
                Text(SessionLocalizedStrings.inSession)
                    .font(.grow(.text400(.large)))
                    .multilineTextAlignment(.center)
                Button(SessionLocalizedStrings.exit, action: {})
                    .buttonStyle(CTAButtonStyleBlack())
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
    }
}

#Preview {
    LiveSessionView()
}
