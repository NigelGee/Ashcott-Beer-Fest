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

            Button {
                Task {
                    await action()
                }
                dismiss()
            } label: {
                Text("Try Again")
                    .frame(maxWidth: .infinity)
            }

            .buttonStyle(.bordered)
            .padding()

            Button {
                dismiss()
            } label: {
                Text("Dismiss")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ErrorLoadingView() { }
}
