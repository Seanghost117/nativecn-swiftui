import SwiftUI

/// A compact container for related button actions.
public struct CNButtonGroup<Content: View>: View {
    /// Button group orientation.
    public enum Orientation: String, CaseIterable, Sendable, Equatable {
        /// Horizontal button group.
        case horizontal

        /// Vertical button group.
        case vertical
    }

    @Environment(\.cnTheme) private var theme

    private let orientation: Orientation
    private let content: Content

    /// Creates a button group.
    public init(orientation: Orientation = .horizontal, @ViewBuilder content: () -> Content) {
        self.orientation = orientation
        self.content = content()
    }

    /// The button group body.
    public var body: some View {
        Group {
            switch orientation {
            case .horizontal:
                HStack(spacing: theme.space.x2) {
                    content
                }
            case .vertical:
                VStack(alignment: .leading, spacing: theme.space.x2) {
                    content
                }
            }
        }
        .padding(theme.space.x1)
        .background(theme.colors.muted.color.opacity(0.45))
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .accessibilityElement(children: .contain)
    }
}

