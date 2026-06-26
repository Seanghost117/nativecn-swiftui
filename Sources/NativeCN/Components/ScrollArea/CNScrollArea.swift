import SwiftUI

/// A constrained native scroll viewport for long content regions.
public struct CNScrollArea<Content: View>: View {
    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let maxHeight: CGFloat?
    private let maxWidth: CGFloat?
    private let content: Content

    /// Creates a scroll area.
    public init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        maxHeight: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.maxHeight = Self.normalizedLength(maxHeight)
        self.maxWidth = Self.normalizedLength(maxWidth)
        self.content = content()
    }

    /// The scroll area body.
    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            content
                .frame(maxWidth: axes.contains(.horizontal) ? nil : .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: maxWidth ?? .infinity, maxHeight: maxHeight, alignment: .topLeading)
    }

    /// Returns a layout-safe length, or nil when the length should be unconstrained.
    public static func normalizedLength(_ length: CGFloat?) -> CGFloat? {
        guard let length, length.isFinite, length > 0 else {
            return nil
        }

        return length
    }
}

public extension View {
    /// Wraps a view in a constrained native scroll area.
    func cnScrollArea(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        maxHeight: CGFloat? = nil,
        maxWidth: CGFloat? = nil
    ) -> some View {
        CNScrollArea(
            axes,
            showsIndicators: showsIndicators,
            maxHeight: maxHeight,
            maxWidth: maxWidth
        ) {
            self
        }
    }
}
