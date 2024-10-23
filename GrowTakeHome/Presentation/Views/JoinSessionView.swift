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
        static let horizontalPadding: CGFloat = 16
    }
    
    var body: some View {
        ZStack {
            Color.colorNeutralGreen
                .ignoresSafeArea()
            VStack(spacing: Constants.verticalSpacing) {
                Text(SessionLocalizedStrings.waitingForProvider)
                    .font(.grow(.text400(.large)))
                Text(SessionLocalizedStrings.waitingRoomDescriptionMessage)
                    .font(.grow(.text400(.regular)))
                    .multilineTextAlignment(.center)
                
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
    }
}

#Preview {
    JoinSessionView()
}
