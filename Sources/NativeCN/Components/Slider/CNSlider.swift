import SwiftUI

/// A native slider with NativeCN tint, value clamping, and optional value display.
public struct CNSlider: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var value: Double
    private let bounds: ClosedRange<Double>
    private let step: Double?
    private let label: String?
    private let showsValue: Bool
    private let isDisabled: Bool

    /// Creates a slider.
    public init(
        value: Binding<Double>,
        in bounds: ClosedRange<Double> = 0...1,
        step: Double? = nil,
        label: String? = nil,
        showsValue: Bool = false,
        isDisabled: Bool = false
    ) {
        self._value = value
        self.bounds = bounds
        self.step = step
        self.label = label
        self.showsValue = showsValue
        self.isDisabled = isDisabled
    }

    /// Returns a value clamped into the provided bounds.
    public static func clamped(_ value: Double, in bounds: ClosedRange<Double>) -> Double {
        min(max(value, bounds.lowerBound), bounds.upperBound)
    }

    /// The slider body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x2) {
            if label != nil || showsValue {
                HStack {
                    if let label {
                        Text(label)
                            .font(theme.typography.subheadline.font)
                            .foregroundStyle(theme.colors.foreground.color)
                    }

                    Spacer()

                    if showsValue {
                        Text(formattedValue)
                            .font(theme.typography.footnote.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }
            }

            slider
                .tint(theme.colors.primary.color)
                .disabled(isDisabled)
                .opacity(isDisabled ? 0.55 : 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Slider")
        .accessibilityValue(formattedValue)
    }

    @ViewBuilder
    private var slider: some View {
        if let step {
            Slider(value: clampedBinding, in: bounds, step: step)
        } else {
            Slider(value: clampedBinding, in: bounds)
        }
    }

    private var clampedBinding: Binding<Double> {
        Binding {
            Self.clamped(value, in: bounds)
        } set: { newValue in
            value = Self.clamped(newValue, in: bounds)
        }
    }

    private var formattedValue: String {
        let clamped = Self.clamped(value, in: bounds)
        if bounds == 0...1 {
            return "\(Int((clamped * 100).rounded()))%"
        }
        return String(format: "%.2f", clamped)
    }
}
