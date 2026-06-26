import SwiftUI

/// A content-oriented callout for guidance, tips, and important notes.
public struct CNCallout<Actions: View>: View {
    /// Callout visual variants.
    public enum Variant: String, CaseIterable, Sendable, Equatable {
        /// Neutral informational callout.
        case info

        /// Successful or positive callout.
        case success

        /// Warning callout.
        case warning

        /// Destructive or critical callout.
        case destructive
    }

    @Environment(\.cnTheme) private var theme

    private let title: String
    private let message: String?
    private let variant: Variant
    private let systemImage: String?
    private let actions: Actions

    /// Creates a callout.
    public init(
        _ title: String,
        message: String? = nil,
        variant: Variant = .info,
        systemImage: String? = nil,
        @ViewBuilder actions: () -> Actions
    ) {
        self.title = title
        self.message = message
        self.variant = variant
        self.systemImage = systemImage
        self.actions = actions()
    }

    /// The callout body.
    public var body: some View {
        let style = variant.style(in: theme)

        HStack(alignment: .top, spacing: theme.space.x3) {
            Image(systemName: systemImage ?? variant.defaultSystemImage)
                .font(.headline)
                .foregroundStyle(style.foreground.color)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.space.x2) {
                Text(title)
                    .font(theme.typography.headline.font)
                    .foregroundStyle(style.foreground.color)

                if let message {
                    Text(message)
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(style.messageForeground.color)
                }

                actions
            }
        }
        .padding(theme.space.x4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(style.background.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: style.border, cornerRadius: theme.radius.lg)
        .accessibilityElement(children: .combine)
    }
}

public extension CNCallout where Actions == EmptyView {
    /// Creates a callout without actions.
    init(_ title: String, message: String? = nil, variant: Variant = .info, systemImage: String? = nil) {
        self.init(title, message: message, variant: variant, systemImage: systemImage) {
            EmptyView()
        }
    }
}

/// Resolved style values for a callout.
public struct CNCalloutStyleValues: Sendable, Equatable {
    /// Callout background.
    public var background: CNColorToken

    /// Primary foreground.
    public var foreground: CNColorToken

    /// Message foreground.
    public var messageForeground: CNColorToken

    /// Border color.
    public var border: CNColorToken

    /// Creates callout style values.
    public init(background: CNColorToken, foreground: CNColorToken, messageForeground: CNColorToken, border: CNColorToken) {
        self.background = background
        self.foreground = foreground
        self.messageForeground = messageForeground
        self.border = border
    }
}

public extension CNCallout.Variant {
    /// Default SF Symbol for this callout variant.
    var defaultSystemImage: String {
        switch self {
        case .info:
            return "info.circle"
        case .success:
            return "checkmark.circle"
        case .warning:
            return "exclamationmark.triangle"
        case .destructive:
            return "xmark.octagon"
        }
    }

    /// Resolves this variant to theme-derived style values.
    func style(in theme: CNTheme) -> CNCalloutStyleValues {
        switch self {
        case .info:
            return CNCalloutStyleValues(
                background: theme.colors.card,
                foreground: theme.colors.cardForeground,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.border
            )
        case .success:
            return CNCalloutStyleValues(
                background: theme.colors.accent,
                foreground: theme.colors.accentForeground,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.ring
            )
        case .warning:
            return CNCalloutStyleValues(
                background: theme.colors.secondary,
                foreground: theme.colors.secondaryForeground,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.border
            )
        case .destructive:
            return CNCalloutStyleValues(
                background: theme.colors.background,
                foreground: theme.colors.destructive,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.destructive
            )
        }
    }
}
