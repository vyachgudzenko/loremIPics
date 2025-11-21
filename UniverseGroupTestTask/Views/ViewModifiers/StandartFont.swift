//
//  StandartFont.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import SwiftUI

struct StandartFont: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
    }
}

extension View {
    func standartFont(size: CGFloat, weight: Font.Weight) -> some View {
        modifier(StandartFont(size: size, weight: weight))
    }
}
