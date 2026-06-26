import SwiftUI

/// A token-driven horizontal or vertical separator.
public struct CNSeparator: View {
    /// Separator orientation.
    public enum Orientation: String, Sendable, Equatable {
        /// Horizontal separator for vertical stacks.
        case horizontal

        /// Vertical separator for horizontal stacks.
        case vertical
    }

    @Environment(\.cnTheme) private var theme

    private let orientation: Orientation
    private let thickness: CGFloat

    /// Creates a separator.
    public init(_ orientation: Orientation = .horizontal, thickness: CGFloat = 1) {
        self.orientation = orientation
        self.thickness = thickness
    }

    /// The separator body.
    public var body: some View {
        Rectangle()
            .fill(theme.colors.border.color)
            .frame(
                width: orientation == .vertical ? thickness : nil,
                height: orientation == .horizontal ? thickness : nil
            )
            .frame(
                maxWidth: orientation == .horizontal ? .infinity : nil,
                maxHeight: orientation == .vertical ? .infinity : nil
            )
            .accessibilityHidden(true)
    }
}
