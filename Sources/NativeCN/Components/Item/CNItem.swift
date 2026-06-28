import SwiftUI

/// A flexible row for settings, command, and menu-like content.
public struct CNItem<Leading: View, Trailing: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let subtitle: String?
    private let isDisabled: Bool
    private let leading: Leading
    private let trailing: Trailing

    /// Creates an item row.
    public init(
        _ title: String,
        subtitle: String? = nil,
        isDisabled: Bool = false,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.isDisabled = isDisabled
        self.leading = leading()
        self.trailing = trailing()
    }

    /// The item body.
    public var body: some View {
        HStack(alignment: .center, spacing: theme.space.x3) {
            if Leading.self != EmptyView.self {
                leading
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .frame(width: 24)
            }

            VStack(alignment: .leading, spacing: theme.space.x1) {
                Text(title)
                    .font(theme.typography.body.font.weight(.medium))
                    .foregroundStyle(theme.colors.foreground.color)

                if let subtitle {
                    Text(subtitle)
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }
            }

            Spacer(minLength: theme.space.x3)

            if Trailing.self != EmptyView.self {
                trailing
                    .foregroundStyle(theme.colors.mutedForeground.color)
            }
        }
        .padding(.horizontal, theme.space.x4)
        .padding(.vertical, theme.space.x3)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .combine)
    }
}

public extension CNItem where Leading == EmptyView, Trailing == EmptyView {
    /// Creates an item without accessory content.
    init(_ title: String, subtitle: String? = nil, isDisabled: Bool = false) {
        self.init(title, subtitle: subtitle, isDisabled: isDisabled) {
            EmptyView()
        } trailing: {
            EmptyView()
        }
    }
}

public extension CNItem where Leading == Image, Trailing == EmptyView {
    /// Creates an item with a leading SF Symbol.
    init(_ title: String, subtitle: String? = nil, systemImage: String, isDisabled: Bool = false) {
        self.init(title, subtitle: subtitle, isDisabled: isDisabled) {
            Image(systemName: systemImage)
        } trailing: {
            EmptyView()
        }
    }
}
