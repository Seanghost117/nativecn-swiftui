import SwiftUI

/// A form label with NativeCN typography and optional required indicator.
public struct CNLabel: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let isRequired: Bool

    /// Creates a form label.
    public init(_ title: String, isRequired: Bool = false) {
        self.title = title
        self.isRequired = isRequired
    }

    /// The label body.
    public var body: some View {
        HStack(spacing: theme.space.x1) {
            Text(title)
                .font(theme.typography.subheadline.font.weight(.medium))
                .foregroundStyle(theme.colors.foreground.color)

            if isRequired {
                Text("*")
                    .font(theme.typography.subheadline.font.weight(.semibold))
                    .foregroundStyle(theme.colors.destructive.color)
                    .accessibilityHidden(true)
            }
        }
        .accessibilityLabel(isRequired ? "\(title), required" : title)
    }
}
