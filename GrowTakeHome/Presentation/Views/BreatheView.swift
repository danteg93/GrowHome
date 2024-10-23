//
//  BreatheView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct BreatheViewModel: Hashable {
    let breathCount: Int
    let taskId: UUID
    
    func completeTask() async {
        try? await TasksClientImpl.shared.completeTask(id: taskId)
    }
}

struct BreatheView: View {
    
    enum Constants {
        static let topTitleVerticalSpacing: CGFloat = 46
        static let breatheCountHeight: CGFloat = 143
        static let circleMaxHeight: CGFloat = 200
        static let breathDuration: TimeInterval = 4
        static let circleShrinkScale: CGFloat = 0.25
    }
    
    let viewModel: BreatheViewModel
    @ObservedObject var navigationState: NavigationState
    
    @State var currentBreathCount: Int
    @State var circleScale: CGFloat = 1
    
    let timer = Timer.publish(
        every: Constants.breathDuration * 2,
        on: .main,
        in: .common
    ).autoconnect()
    
    init(viewModel: BreatheViewModel,
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
                Text("\(currentBreathCount)")
                    .font(.grow(.header700(.large)))
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
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            circleScale = Constants.circleShrinkScale
        }
        .onReceive(timer) { _ in
            currentBreathCount -= 1
            if currentBreathCount <= 0 {
                self.timer.upstream.connect().cancel()
            }
        }
    }
}

#Preview {
    BreatheView(viewModel: .init(breathCount: 2, taskId: UUID()),
                navigationState: NavigationState())
}
