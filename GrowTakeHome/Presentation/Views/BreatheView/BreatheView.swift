//
//  BreatheView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct BreatheView: View {
    
    enum Constants {
        static let topTitleVerticalSpacing: CGFloat = 46
        static let bottomSpacerHeight: CGFloat = 32
        static let breatheCountHeight: CGFloat = 143
        static let circleMaxHeight: CGFloat = 200
        static let breathDuration: TimeInterval = 4
        static let circleShrinkScale: CGFloat = 0.25
        static let joinProviderVerticalSpacing: CGFloat = 8
    }
    
    let viewModel: BreatheViewViewModel
    @ObservedObject var navigationState: NavigationState
    
    @State var currentBreathCount: Int
    @State var circleScale: CGFloat = 1
    @State var viewHasTransitioned = false
    
    let timer = Timer.publish(
        every: Constants.breathDuration * 2,
        on: .main,
        in: .common
    ).autoconnect()
    
    init(viewModel: BreatheViewViewModel,
         navigationState: NavigationState) {
        self.viewModel = viewModel
        self.currentBreathCount = viewModel.breathCount
        self.navigationState = navigationState
    }
    
    var body: some View {
        ZStack {
            Color.colorBackgroundPrimary
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: Constants.topTitleVerticalSpacing)
                Text(BreatheLocalizedStrings.breatheFor)
                    .font(.grow(.header700(.regular)))
                    .foregroundStyle(.colorNeutralBlack)
                Text("\(currentBreathCount)")
                    .font(.grow(.header700(.large)))
                    .foregroundStyle(.colorNeutralBlack)
                    .frame(height: Constants.breatheCountHeight)
                Circle()
                    .frame(
                        width: Constants.circleMaxHeight,
                        height: Constants.circleMaxHeight)
                    .foregroundColor(.colorBackgroundSecondary)
                    .scaleEffect(circleScale)
                    .animation(
                        .easeInOut(duration: Constants.breathDuration)
                        .repeatCount((viewModel.breathCount * 2) + 1, autoreverses: true),
                        value: circleScale)
                Spacer()
                if (viewModel.providerHasJoined) {
                    VStack(spacing: Constants.joinProviderVerticalSpacing) {
                        Text(SessionLocalizedStrings.providerInSession)
                            .font(.grow(.text400(.regular)))
                            .multilineTextAlignment(.center)
                        Button(SessionLocalizedStrings.joinNow, action: {
                            viewModel.navigateToNextView(startSession: true, with: navigationState)
                        })
                            .buttonStyle(CTAButtonStyleGreen())
                    }
                }
                Spacer()
                    .frame(height: Constants.bottomSpacerHeight)
            }
        }
        .onAppear {
            circleScale = Constants.circleShrinkScale
        }
        .onReceive(timer) { _ in
            currentBreathCount -= 1
            if currentBreathCount <= 0 {
                timer.upstream.connect().cancel()
                if !viewHasTransitioned {
                    viewHasTransitioned = true
                    viewModel.navigateToNextView(startSession: false, with: navigationState)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BreatheView(viewModel: .init(breathCount: 2, taskEntityId: UUID()),
                navigationState: NavigationState())
}
