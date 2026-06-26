import SwiftUI

/// A token-driven inline alert surface for status, warning, and error feedback.
public struct CNAlert<Actions: View>: View {
    /// Alert visual variants.
    public enum Variant: String, CaseIterable, Sendable, Equatable {
        /// Neutral informational alert.
        case `default`

        /// Success alert.
        case success

        /// Warning alert.
        case warning

        /// Destructive or error alert.
        case destructive
    }

    @Environment(\.cnTheme) private var theme

    private let title: String
    private let message: String?
    private let variant: Variant
    private let systemImage: String?
    private let actions: Actions

    /// Creates an alert.
    public init(
        _ title: String,
        message: String? = nil,
        variant: Variant = .default,
        systemImage: String? = nil,
        @ViewBuilder actions: () -> Actions
    ) {
        self.title = title
        self.message = message
        self.variant = variant
        self.systemImage = systemImage
        self.actions = actions()
    }

    /// The alert body.
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

public extension CNAlert where Actions == EmptyView {
    /// Creates an alert without actions.
    init(
        _ title: String,
        message: String? = nil,
        variant: Variant = .default,
        systemImage: String? = nil
    ) {
        self.init(title, message: message, variant: variant, systemImage: systemImage) {
            EmptyView()
        }
    }
}

/// Resolved style values for an alert variant.
public struct CNAlertStyleValues: Sendable, Equatable {
    /// Alert background.
    public var background: CNColorToken

    /// Primary alert foreground.
    public var foreground: CNColorToken

    /// Message foreground.
    public var messageForeground: CNColorToken

    /// Alert border.
    public var border: CNColorToken

    /// Creates alert style values.
    public init(background: CNColorToken, foreground: CNColorToken, messageForeground: CNColorToken, border: CNColorToken) {
        self.background = background
        self.foreground = foreground
        self.messageForeground = messageForeground
        self.border = border
    }
}

public extension CNAlert.Variant {
    /// Default SF Symbol for this alert variant.
    var defaultSystemImage: String {
        switch self {
        case .default:
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
    func style(in theme: CNTheme) -> CNAlertStyleValues {
        switch self {
        case .default:
            return CNAlertStyleValues(
                background: theme.colors.card,
                foreground: theme.colors.cardForeground,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.border
            )
        case .success:
            return CNAlertStyleValues(
                background: theme.colors.accent,
                foreground: theme.colors.accentForeground,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.ring
            )
        case .warning:
            return CNAlertStyleValues(
                background: theme.colors.secondary,
                foreground: theme.colors.secondaryForeground,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.border
            )
        case .destructive:
            return CNAlertStyleValues(
                background: theme.colors.background,
                foreground: theme.colors.destructive,
                messageForeground: theme.colors.mutedForeground,
                border: theme.colors.destructive
            )
        }
    }
}
