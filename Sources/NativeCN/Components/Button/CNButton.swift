import SwiftUI

/// A token-driven SwiftUI button with NativeCN variants, sizes, and loading support.
public struct CNButton<Label: View>: View {
    /// Visual button variants.
    public enum Variant: String, CaseIterable, Sendable, Equatable {
        /// Primary action button.
        case primary

        /// Secondary action button.
        case secondary

        /// Destructive action button.
        case destructive

        /// Outlined action button.
        case outline

        /// Low-emphasis ghost button.
        case ghost

        /// Link-style button.
        case link
    }

    /// Button size scale.
    public typealias Size = CNControlSize

    @Environment(\.cnTheme) private var theme

    private let variant: Variant
    private let size: Size
    private let role: ButtonRole?
    private let isLoading: Bool
    private let isDisabled: Bool
    private let loadingLabel: String
    private let action: () -> Void
    private let label: Label

    /// Creates a button with custom label content.
    public init(
        variant: Variant = .primary,
        size: Size = .md,
        role: ButtonRole? = nil,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        loadingLabel: String = "Loading",
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.variant = variant
        self.size = size
        self.role = role
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.loadingLabel = loadingLabel
        self.action = action
        self.label = label()
    }

    /// The button body.
    public var body: some View {
        let metrics = size.metrics(in: theme)

        Button(role: role) {
            guard !isLoading else { return }
            action()
        } label: {
            HStack(spacing: metrics.spacing) {
                if isLoading {
                    CNLoadingIndicator(
                        size: metrics.iconLength,
                        color: variant.style(in: theme).foreground,
                        label: loadingLabel
                    )
                }

                label
                    .opacity(isLoading ? 0.82 : 1)
            }
        }
        .buttonStyle(CNButtonStyle<Label>(variant: variant, size: size, isLoading: isLoading))
        .disabled(isDisabled || isLoading)
        .accessibilityValue(isLoading ? Text(loadingLabel) : Text(""))
    }
}

public extension CNButton where Label == Text {
    /// Creates a button with a text label.
    init(
        _ title: String,
        variant: Variant = .primary,
        size: Size = .md,
        role: ButtonRole? = nil,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        loadingLabel: String = "Loading",
        action: @escaping () -> Void
    ) {
        self.init(
            variant: variant,
            size: size,
            role: role,
            isLoading: isLoading,
            isDisabled: isDisabled,
            loadingLabel: loadingLabel,
            action: action
        ) {
            Text(title)
        }
    }
}

/// SwiftUI button style used by `CNButton`.
public struct CNButtonStyle<Label: View>: ButtonStyle {
    @Environment(\.cnTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    private let variant: CNButton<Label>.Variant
    private let size: CNControlSize
    private let isLoading: Bool

    /// Creates a NativeCN button style.
    public init(variant: CNButton<Label>.Variant = .primary, size: CNControlSize = .md, isLoading: Bool = false) {
        self.variant = variant
        self.size = size
        self.isLoading = isLoading
    }

    /// Creates the styled button body.
    public func makeBody(configuration: Configuration) -> some View {
        let metrics = size.metrics(in: theme)
        let state = CNControlState(
            isEnabled: isEnabled,
            isPressed: configuration.isPressed,
            isLoading: isLoading
        )
        let style = variant.style(in: theme)

        configuration.label
            .font(theme.typography.body.font.weight(.medium))
            .lineLimit(1)
            .minimumScaleFactor(0.85)
            .foregroundStyle(style.foreground.color)
            .padding(.horizontal, metrics.horizontalPadding)
            .frame(minWidth: metrics.minWidth, minHeight: metrics.height)
            .background(style.background.color)
            .clipShape(RoundedRectangle(cornerRadius: metrics.cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: metrics.cornerRadius)
                    .stroke(style.border.color, lineWidth: style.borderWidth)
            }
            .opacity(state.isInteractive ? 1 : 0.55)
            .contentShape(RoundedRectangle(cornerRadius: metrics.cornerRadius))
            .cnInteractiveScale(isPressed: configuration.isPressed)
    }
}

/// Resolved style values for a NativeCN button variant.
public struct CNButtonStyleValues: Sendable, Equatable {
    /// Button background color.
    public var background: CNColorToken

    /// Button foreground color.
    public var foreground: CNColorToken

    /// Button border color.
    public var border: CNColorToken

    /// Button border width.
    public var borderWidth: CGFloat

    /// Creates button style values.
    public init(background: CNColorToken, foreground: CNColorToken, border: CNColorToken, borderWidth: CGFloat) {
        self.background = background
        self.foreground = foreground
        self.border = border
        self.borderWidth = borderWidth
    }
}

public extension CNButton.Variant {
    /// Resolves this variant to theme-derived style values.
    func style(in theme: CNTheme) -> CNButtonStyleValues {
        let clear = CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)

        switch self {
        case .primary:
            return CNButtonStyleValues(
                background: theme.colors.primary,
                foreground: theme.colors.primaryForeground,
                border: theme.colors.primary,
                borderWidth: 0
            )
        case .secondary:
            return CNButtonStyleValues(
                background: theme.colors.secondary,
                foreground: theme.colors.secondaryForeground,
                border: theme.colors.secondary,
                borderWidth: 0
            )
        case .destructive:
            return CNButtonStyleValues(
                background: theme.colors.destructive,
                foreground: theme.colors.destructiveForeground ?? theme.colors.primaryForeground,
                border: theme.colors.destructive,
                borderWidth: 0
            )
        case .outline:
            return CNButtonStyleValues(
                background: theme.colors.background,
                foreground: theme.colors.foreground,
                border: theme.colors.border,
                borderWidth: 1
            )
        case .ghost:
            return CNButtonStyleValues(
                background: clear,
                foreground: theme.colors.foreground,
                border: clear,
                borderWidth: 0
            )
        case .link:
            return CNButtonStyleValues(
                background: clear,
                foreground: theme.colors.primary,
                border: clear,
                borderWidth: 0
            )
        }
    }
}
