//
//  ContentView.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.colorBackgroundPrimary
                .ignoresSafeArea()
            VStack {
                Text("My Tasks")
                    .font(.grow(.header700(.regular)))
                
                TaskRow()
                TaskRow()
                TaskRow()
            }
            .padding()
            .background(.colorBackgroundPrimary).edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}
