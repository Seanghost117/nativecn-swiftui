import SwiftUI

/// A compact row for settings, menus, and grouped lists.
public struct CNListRow<Leading: View, Trailing: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let subtitle: String?
    private let leading: Leading
    private let trailing: Trailing
    private let action: (() -> Void)?

    /// Creates a list row.
    public init(
        _ title: String,
        subtitle: String? = nil,
        action: (() -> Void)? = nil,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        self.leading = leading()
        self.trailing = trailing()
    }

    /// The row body.
    public var body: some View {
        let row = HStack(spacing: theme.space.x3) {
            leading

            VStack(alignment: .leading, spacing: theme.space.x1) {
                Text(title)
                    .font(theme.typography.body.font)
                    .foregroundStyle(theme.colors.foreground.color)

                if let subtitle {
                    Text(subtitle)
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }
            }

            Spacer(minLength: theme.space.x3)

            trailing
        }
        .padding(.horizontal, theme.space.x4)
        .padding(.vertical, theme.space.x3)
        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)

        if let action {
            Button(action: action) {
                row
            }
            .buttonStyle(.plain)
        } else {
            row
        }
    }
}

public extension CNListRow where Leading == EmptyView, Trailing == EmptyView {
    /// Creates a plain text row.
    init(_ title: String, subtitle: String? = nil, action: (() -> Void)? = nil) {
        self.init(title, subtitle: subtitle, action: action) {
            EmptyView()
        } trailing: {
            EmptyView()
        }
    }
}

public extension CNListRow where Leading == Image, Trailing == EmptyView {
    /// Creates a row with an SF Symbol leading icon.
    init(_ title: String, subtitle: String? = nil, systemImage: String, action: (() -> Void)? = nil) {
        self.init(title, subtitle: subtitle, action: action) {
            Image(systemName: systemImage)
        } trailing: {
            EmptyView()
        }
    }
}
