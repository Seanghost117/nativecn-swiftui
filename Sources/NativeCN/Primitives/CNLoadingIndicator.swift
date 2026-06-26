import SwiftUI

/// A small token-colored loading indicator for NativeCN controls.
public struct CNLoadingIndicator: View {
    @Environment(\.cnTheme) private var theme

    private let size: CGFloat
    private let color: CNColorToken?
    private let label: String

    /// Creates a loading indicator.
    public init(size: CGFloat = 16, color: CNColorToken? = nil, label: String = "Loading") {
        self.size = size
        self.color = color
        self.label = label
    }

    /// The indicator body.
    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint((color ?? theme.colors.primary).color)
            .frame(width: size, height: size)
            .accessibilityLabel(label)
    }
}
