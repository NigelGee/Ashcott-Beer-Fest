//
//  View - Extension.swift
//  Ashcott
//
//  Created by Nigel Gee on 05/06/2026.
//

import SwiftUI

extension View {
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
}
