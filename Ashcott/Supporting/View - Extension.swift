//
//  View - Extension.swift
//  Ashcott
//
//  Created by Nigel Gee on 05/06/2026.
//

import SwiftUI

extension View {

    /// A computed property that return a purple capsule color for the date of festival
    var purpleCapsuleModifier: some View {
        self
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(.purple.gradient)
            .clipShape(.capsule)
            .padding(.bottom)
            .foregroundStyle(.white)
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }


    /// A purple color for news list rows
    /// - Parameters:
    ///   - date: A bool for news date and control date
    ///   - withoutColor: Environment accessibilityDifferentiateWithoutColor
    /// - Returns: Color purple if not true for either parameters
    func bgPurpleColor(_ date: Bool, or withoutColor: Bool) -> Color? {
        if date || withoutColor {
            return nil
        }

        return Color.purple.opacity(0.2)
    }
}
