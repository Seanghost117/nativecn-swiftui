import SwiftUI

/// A compact semantic status indicator.
public struct CNStatusBadge: View {
    /// Status badge variants.
    public enum Variant: String, CaseIterable, Sendable, Equatable {
        /// Neutral status.
        case neutral

        /// Successful or healthy status.
        case success

        /// Warning status.
        case warning

        /// Destructive or error status.
        case destructive
    }

    @Environment(\.cnTheme) private var theme

    private let title: String
    private let variant: Variant
    private let showsDot: Bool

    /// Creates a status badge.
    public init(_ title: String, variant: Variant = .neutral, showsDot: Bool = true) {
        self.title = title
        self.variant = variant
        self.showsDot = showsDot
    }

    /// The status badge body.
    public var body: some View {
        let style = variant.style(in: theme)

        HStack(spacing: theme.space.x1) {
            if showsDot {
                Circle()
                    .fill(style.dot.color)
                    .frame(width: 6, height: 6)
                    .accessibilityHidden(true)
            }

            Text(title)
        }
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
                .stroke(style.border.color, lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
    }
}

/// Resolved style values for a status badge.
public struct CNStatusBadgeStyleValues: Sendable, Equatable {
    /// Badge background.
    public var background: CNColorToken

    /// Badge foreground.
    public var foreground: CNColorToken

    /// Badge border.
    public var border: CNColorToken

    /// Dot color.
    public var dot: CNColorToken

    /// Creates status badge style values.
    public init(background: CNColorToken, foreground: CNColorToken, border: CNColorToken, dot: CNColorToken) {
        self.background = background
        self.foreground = foreground
        self.border = border
        self.dot = dot
    }
}

public extension CNStatusBadge.Variant {
    /// Resolves this variant to theme-derived style values.
    func style(in theme: CNTheme) -> CNStatusBadgeStyleValues {
        switch self {
        case .neutral:
            return CNStatusBadgeStyleValues(
                background: theme.colors.secondary,
                foreground: theme.colors.secondaryForeground,
                border: theme.colors.border,
                dot: theme.colors.mutedForeground
            )
        case .success:
            return CNStatusBadgeStyleValues(
                background: theme.colors.accent,
                foreground: theme.colors.accentForeground,
                border: theme.colors.ring,
                dot: theme.colors.ring
            )
        case .warning:
            return CNStatusBadgeStyleValues(
                background: theme.colors.background,
                foreground: theme.colors.foreground,
                border: theme.colors.border,
                dot: theme.colors.chart4
            )
        case .destructive:
            return CNStatusBadgeStyleValues(
                background: theme.colors.background,
                foreground: theme.colors.destructive,
                border: theme.colors.destructive,
                dot: theme.colors.destructive
            )
        }
    }
}
