//
//  BreatheView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct BreatheViewModel {
    let name: String
}

struct BreatheView: View {
    
    let viewModel: BreatheViewModel
    
    init(viewModel: BreatheViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(viewModel.name)
            .font(.largeTitle.bold())
    }
}

#Preview {
    BreatheView(viewModel: .init(name: "WoW"))
}
