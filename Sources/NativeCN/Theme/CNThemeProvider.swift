import SwiftUI

/// Provides a NativeCN theme to a SwiftUI view subtree.
public struct CNThemeProvider<Content: View>: View {
    private let theme: CNTheme
    private let content: Content

    /// Creates a provider that injects a theme into its content.
    public init(_ theme: CNTheme = .default, @ViewBuilder content: () -> Content) {
        self.theme = theme
        self.content = content()
    }

    /// The provider body.
    public var body: some View {
        content.environment(\.cnTheme, theme)
    }
}
