import SwiftUI

/// A token-driven determinate progress indicator.
public struct CNProgress: View {
    @Environment(\.cnTheme) private var theme

    private let value: Double
    private let label: String?
    private let height: CGFloat

    /// Creates a progress indicator.
    public init(value: Double, label: String? = nil, height: CGFloat = 8) {
        self.value = value
        self.label = label
        self.height = height
    }

    /// The clamped value in the `0...1` range.
    public var clampedValue: Double {
        Self.clamped(value)
    }

    /// Clamps a progress value to the supported `0...1` range.
    public static func clamped(_ value: Double) -> Double {
        min(max(value, 0), 1)
    }

    /// The progress body.
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(theme.colors.muted.color)

                Capsule()
                    .fill(theme.colors.primary.color)
                    .frame(width: proxy.size.width * clampedValue)
            }
        }
        .frame(height: height)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label ?? "Progress")
        .accessibilityValue("\(Int((clampedValue * 100).rounded())) percent")
    }
}
