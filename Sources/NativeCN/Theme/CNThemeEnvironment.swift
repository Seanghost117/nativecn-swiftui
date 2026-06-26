import SwiftUI

private struct CNThemeKey: EnvironmentKey {
    static let defaultValue = CNTheme.default
}

public extension EnvironmentValues {
    /// The active NativeCN theme for the current SwiftUI environment.
    var cnTheme: CNTheme {
        get { self[CNThemeKey.self] }
        set { self[CNThemeKey.self] = newValue }
    }
}

public extension View {
    /// Overrides the active NativeCN theme for this view subtree.
    func cnTheme(_ theme: CNTheme) -> some View {
        environment(\.cnTheme, theme)
    }
}
