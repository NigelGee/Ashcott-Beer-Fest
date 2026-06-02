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
        NavigationStack {
            ContentUnavailableView {
                Label("Something went wrong!", systemImage: "wifi")
            } description: {
                VStack(alignment: .leading) {
                    Text("It might be…")
                        .font(.title2)
                    HStack(alignment: .top) {
                        Text("1.")
                        Text("You not connect to internet!")
                    }
                    HStack(alignment: .top) {
                        Text("2.")
                        Text("It has recent updated. Please wait and try again.")
                            .multilineTextAlignment(.leading)
                    }
                }
            } actions: {
                Button {
                    Task {
                        await action()
                    }
                    dismiss()
                } label: {
                    Text("Try Again")
                        .padding(.horizontal)
                }
                .tint(.red)
                .buttonStyle(.bordered)
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Label("Dismiss", systemImage: "xmark.circle")
                }
            }
        }
    }
}

#Preview {
    ErrorLoadingView() { }
}
