//
//  NavigationState.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

// TODO: Comment
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
