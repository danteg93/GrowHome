//
//  GrowTextStyle.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/21/24.
//

import SwiftUI

enum GrowTextStyle {
    
    struct Attributes {
        let size: CGFloat
        let weight: Font.Weight
    }
    
    case header700(GrowTextSize)
    case text400(GrowTextSize)
    
    var attributes: Attributes {
        switch self {
        case .header700(let textSize):
            switch textSize {
            case .regular:
                return .init(size: 34, weight: .bold)
            case .large:
                return .init(size: 60, weight: .bold)
            }
        case .text400(let textSize):
            switch textSize {
            case .regular:
                return .init(size: 17, weight: .regular)
            case .large:
                return .init(size: 34, weight: .regular)
            }
        }
    }
}

enum GrowTextSize {
    case regular
    case large
}

extension Font {
    static func grow(_ textStyle: GrowTextStyle) -> Font {
        Font.system(size: textStyle.attributes.size, weight: textStyle.attributes.weight)
    }
}
