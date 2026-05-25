//
//  ErrorLoadingView.swift
//  Ashcott
//
//  Created by Nigel Gee on 25/05/2026.
//

import SwiftUI

struct ErrorLoadingView: View {
    @Environment(\.dismiss) var dismiss
    let action: () async -> Void

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Something went wrong!")
                    .font(.title)

                Text ("It might be…")
                    .font(.title3)
                Text("""
                1. You not connect to internet!
                2. It has recent updated. Please wait and try again.
                """)
            }

            Button("Try Again") {
                Task {
                    await action()
                }
                dismiss()
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ErrorLoadingView() { }
}
