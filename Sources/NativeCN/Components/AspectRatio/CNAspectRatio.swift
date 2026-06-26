import SwiftUI

/// A fixed-ratio layout container for media and preview surfaces.
public struct CNAspectRatio<Content: View>: View {
    private let ratio: CGFloat
    private let content: Content

    /// Creates an aspect-ratio container.
    ///
    /// The ratio is width divided by height. Invalid ratios fall back to `1`.
    public init(
        _ ratio: CGFloat = 16.0 / 9.0,
        @ViewBuilder content: () -> Content
    ) {
        self.ratio = Self.normalizedRatio(ratio)
        self.content = content()
    }

    /// The aspect-ratio body.
    public var body: some View {
        ZStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .aspectRatio(ratio, contentMode: .fit)
        .frame(maxWidth: .infinity)
        .clipped()
    }

    /// Returns a layout-safe ratio value.
    public static func normalizedRatio(_ ratio: CGFloat) -> CGFloat {
        guard ratio.isFinite, ratio > 0 else {
            return 1
        }

        return ratio
    }
}

public extension View {
    /// Constrains a view to a fixed width-to-height ratio.
    func cnAspectRatio(_ ratio: CGFloat = 16.0 / 9.0) -> some View {
        CNAspectRatio(ratio) {
            self
        }
    }
}
