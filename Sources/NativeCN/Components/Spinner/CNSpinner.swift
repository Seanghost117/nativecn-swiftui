import SwiftUI

/// A token-colored circular loading indicator.
public struct CNSpinner: View {
    @Environment(\.cnTheme) private var theme

    private let size: CGFloat
    private let color: CNColorToken?
    private let label: String

    /// Creates a spinner.
    public init(size: CGFloat = 20, color: CNColorToken? = nil, label: String = "Loading") {
        self.size = size
        self.color = color
        self.label = label
    }

    /// The spinner body.
    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint((color ?? theme.colors.primary).color)
            .frame(width: size, height: size)
            .accessibilityLabel(label)
    }
}
