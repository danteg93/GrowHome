//
//  JoinSessionView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import SwiftUI

struct JoinSessionView: View {
    
    enum Constants {
        static let verticalSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 90
    }
    
    var body: some View {
        ZStack {
            Color.colorBackgroundSecondary
                .ignoresSafeArea()
            VStack(spacing: Constants.verticalSpacing) {
                Text(SessionLocalizedStrings.providerInSession)
                    .font(.grow(.text400(.large)))
                    .multilineTextAlignment(.center)
                Button(SessionLocalizedStrings.joinNow, action: {})
                    .buttonStyle(CTAButtonStyleGreen())
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
    }
}

#Preview {
    JoinSessionView()
}
