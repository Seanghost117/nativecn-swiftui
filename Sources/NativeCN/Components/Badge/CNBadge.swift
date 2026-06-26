import SwiftUI

/// A compact token-driven status or metadata badge.
public struct CNBadge<Content: View>: View {
    /// Visual badge variants.
    public enum Variant: String, CaseIterable, Sendable, Equatable {
        /// Primary badge.
        case primary

        /// Secondary badge.
        case secondary

        /// Destructive badge.
        case destructive

        /// Outlined badge.
        case outline
    }

    @Environment(\.cnTheme) private var theme

    private let variant: Variant
    private let content: Content

    /// Creates a badge with custom content.
    public init(variant: Variant = .primary, @ViewBuilder content: () -> Content) {
        self.variant = variant
        self.content = content()
    }

    /// The badge body.
    public var body: some View {
        let style = variant.style(in: theme)

        content
            .font(theme.typography.caption.font.weight(.medium))
            .lineLimit(1)
            .minimumScaleFactor(0.85)
            .foregroundStyle(style.foreground.color)
            .padding(.horizontal, theme.space.x2)
            .padding(.vertical, theme.space.x1)
            .background(style.background.color)
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(style.border.color, lineWidth: style.borderWidth)
            }
            .accessibilityElement(children: .combine)
    }
}

public extension CNBadge where Content == Text {
    /// Creates a badge with a text label.
    init(_ title: String, variant: Variant = .primary) {
        self.init(variant: variant) {
            Text(title)
        }
    }
}

/// Resolved style values for a NativeCN badge variant.
public struct CNBadgeStyleValues: Sendable, Equatable {
    /// Badge background color.
    public var background: CNColorToken

    /// Badge foreground color.
    public var foreground: CNColorToken

    /// Badge border color.
    public var border: CNColorToken

    /// Badge border width.
    public var borderWidth: CGFloat

    /// Creates badge style values.
    public init(background: CNColorToken, foreground: CNColorToken, border: CNColorToken, borderWidth: CGFloat) {
        self.background = background
        self.foreground = foreground
        self.border = border
        self.borderWidth = borderWidth
    }
}

public extension CNBadge.Variant {
    /// Resolves this variant to theme-derived style values.
    func style(in theme: CNTheme) -> CNBadgeStyleValues {
        switch self {
        case .primary:
            return CNBadgeStyleValues(
                background: theme.colors.primary,
                foreground: theme.colors.primaryForeground,
                border: theme.colors.primary,
                borderWidth: 0
            )
        case .secondary:
            return CNBadgeStyleValues(
                background: theme.colors.secondary,
                foreground: theme.colors.secondaryForeground,
                border: theme.colors.secondary,
                borderWidth: 0
            )
        case .destructive:
            return CNBadgeStyleValues(
                background: theme.colors.destructive,
                foreground: theme.colors.destructiveForeground ?? theme.colors.primaryForeground,
                border: theme.colors.destructive,
                borderWidth: 0
            )
        case .outline:
            return CNBadgeStyleValues(
                background: CNColorToken(red: 0, green: 0, blue: 0, opacity: 0),
                foreground: theme.colors.foreground,
                border: theme.colors.border,
                borderWidth: 1
            )
        }
    }
}
