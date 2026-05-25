//
//  LoadingView.swift
//  Ashcott
//
//  Created by Nigel Gee on 25/05/2026.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            VStack {
                ProgressView()
                    .scaleEffect(2)
                    .padding()
                Text("Loading…")
            }
        }
    }
}

#Preview {
    LoadingView()
}
