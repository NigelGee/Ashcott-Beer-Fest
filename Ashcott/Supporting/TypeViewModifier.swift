//
//  TypeViewModifier.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import SwiftUI

struct TypeViewModifier: ViewModifier {
    let type: String

    var color: Color {
        switch type {
        case "V": .mint
        case "Ve": .green
        default: .orange
        }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .frame(width: 22, height: 22)
            .foregroundStyle(.black)
            .background(color, in: .circle)
    }
}

extension View {

    /// A method that changes the background color
    ///
    /// For use in types of food
    /// - Parameter type: either "G", "V" or "Ve"
    /// - Returns: The color represented by the type
    func bgColor(for type: String) -> some View {
        modifier(TypeViewModifier(type: type))
    }
}
