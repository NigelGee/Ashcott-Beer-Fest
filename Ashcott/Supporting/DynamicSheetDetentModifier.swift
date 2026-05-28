//
//  DynamicSheetDetentModifier.swift
//  Ashcott
//
//  Created by Nigel Gee on 28/05/2026.
//

import SwiftUI

private struct DynamicSheetDetentModifier: ViewModifier {
    /// A property for the height of the content. Set to value to silence warning.
    @State private var height: CGFloat = 10

    /// A property for the additional `PresentationDetent`s.
    let detents: Set<PresentationDetent>?

    /// A computed property to add user `PresentationDetent`s and `.height(height)` together.
    var appliedDetents: Set<PresentationDetent> {
        let newDetents: Set<PresentationDetent> = [.height(height)]
        if let detents {
            return newDetents.union(detents)
        }
        return newDetents
    }

    func body(content: Content) -> some View {
        // This is here if content is bigger then full sheet and to align the top of content to top of sheet.
        ScrollView {
            content
            // Padding to keep content from top of sheet.
                .padding(.top, 30)
                .fixedSize(horizontal: false, vertical: true)
            // Reads the size of content and changes the `@State` property to it size.
                .onGeometryChange(for: CGSize.self) { proxy in
                    proxy.size
                } action: {
                    height = $0.height
                }
            // Applies the `PresentationDetent`s.
                .presentationDetents(appliedDetents)
        }
        // Only allow scroll if content is to big for full sheet.
        .scrollBounceBehavior(.basedOnSize)
    }
}

extension View {
    /// A View Modifier that determines that height of the content in a sheet and adjusts the sheet size to fit.
    /// - Parameter detents: Extra `PresentationDetent`s if required. Default is nil.
    /// - Returns: The modified `View`.
    ///
    /// This will also allow to use the standard sheet size when added. If no additional `PresentationDetent` then it will just use the dynamic size.
    /// - Important: It will use smallest `PresentationDetent` first.
    /// - Important: If variable are passed in it may not work as expected.
    /// - Note: The modifier contain a `ScrollView` that allow scrolling if content is too big. If change to scroll behaviour it need to added to `View` in the `.sheet(isPresented: )`
    func dynamicSheetDetent(with detents: Set<PresentationDetent>? = nil) -> some View {
        modifier(DynamicSheetDetentModifier(detents: detents))
    }
}

