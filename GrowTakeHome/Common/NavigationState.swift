//
//  NavigationState.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

/// Wrapper around NavigationPath in order to streamline access and give pop, push and empty support.
class NavigationState: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    
    func push<V>(_ element: V) -> Void where V:Hashable {
        path.append(element)
    }
    
    func pop() -> Void {
        path.removeLast()
    }
    
    func empty() -> Void {
        path.removeLast(path.count)
    }
}
