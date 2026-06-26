import SwiftUI

/// Theme selection mode for apps that switch between system, explicit, and custom themes.
public enum CNThemeMode: Sendable, Equatable {
    /// Resolve the theme from the platform color scheme.
    case system(light: CNTheme, dark: CNTheme)

    /// Always use a light theme.
    case light(CNTheme)

    /// Always use a dark theme.
    case dark(CNTheme)

    /// Always use a custom theme.
    case custom(CNTheme)

    /// Returns the concrete theme for a SwiftUI color scheme.
    public func resolved(for colorScheme: ColorScheme) -> CNTheme {
        switch self {
        case let .system(light, dark):
            return colorScheme == .dark ? dark : light
        case let .light(theme), let .dark(theme), let .custom(theme):
            return theme
        }
    }
}
