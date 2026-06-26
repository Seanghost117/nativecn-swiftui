import SwiftUI

/// A two-pane resizable layout for inspector and workspace surfaces.
public struct CNResizablePanels<Primary: View, Secondary: View>: View {
    @Environment(\.cnTheme) private var theme

    @State private var internalFraction: CGFloat
    @State private var dragStartFraction: CGFloat?

    private let axis: Axis
    private let externalFraction: Binding<CGFloat>?
    private let minFraction: CGFloat
    private let maxFraction: CGFloat
    private let handleThickness: CGFloat
    private let primary: Primary
    private let secondary: Secondary

    /// Creates resizable panels with internal split state.
    public init(
        axis: Axis = .horizontal,
        initialFraction: CGFloat = 0.5,
        minFraction: CGFloat = 0.2,
        maxFraction: CGFloat = 0.8,
        handleThickness: CGFloat = 12,
        @ViewBuilder primary: () -> Primary,
        @ViewBuilder secondary: () -> Secondary
    ) {
        let bounds = Self.normalizedBounds(minFraction: minFraction, maxFraction: maxFraction)
        self.axis = axis
        self.externalFraction = nil
        self.minFraction = bounds.min
        self.maxFraction = bounds.max
        self.handleThickness = Self.normalizedLength(handleThickness, fallback: 12)
        self.primary = primary()
        self.secondary = secondary()
        self._internalFraction = State(initialValue: Self.normalizedFraction(initialFraction, minFraction: bounds.min, maxFraction: bounds.max))
    }

    /// Creates resizable panels with caller-owned split state.
    public init(
        axis: Axis = .horizontal,
        fraction: Binding<CGFloat>,
        minFraction: CGFloat = 0.2,
        maxFraction: CGFloat = 0.8,
        handleThickness: CGFloat = 12,
        @ViewBuilder primary: () -> Primary,
        @ViewBuilder secondary: () -> Secondary
    ) {
        let bounds = Self.normalizedBounds(minFraction: minFraction, maxFraction: maxFraction)
        self.axis = axis
        self.externalFraction = fraction
        self.minFraction = bounds.min
        self.maxFraction = bounds.max
        self.handleThickness = Self.normalizedLength(handleThickness, fallback: 12)
        self.primary = primary()
        self.secondary = secondary()
        self._internalFraction = State(initialValue: Self.normalizedFraction(fraction.wrappedValue, minFraction: bounds.min, maxFraction: bounds.max))
    }

    /// The resizable panels body.
    public var body: some View {
        GeometryReader { proxy in
            let totalLength = axis == .horizontal ? proxy.size.width : proxy.size.height
            let availableLength = max(0, totalLength - handleThickness)
            let primaryLength = availableLength * currentFraction
            let secondaryLength = max(0, availableLength - primaryLength)

            if axis == .horizontal {
                HStack(spacing: 0) {
                    primary
                        .frame(width: primaryLength)

                    resizeHandle(availableLength: availableLength)

                    secondary
                        .frame(width: secondaryLength)
                }
            } else {
                VStack(spacing: 0) {
                    primary
                        .frame(height: primaryLength)

                    resizeHandle(availableLength: availableLength)

                    secondary
                        .frame(height: secondaryLength)
                }
            }
        }
    }

    /// Returns a layout-safe split fraction.
    public static func normalizedFraction(
        _ fraction: CGFloat,
        minFraction: CGFloat = 0.2,
        maxFraction: CGFloat = 0.8
    ) -> CGFloat {
        let bounds = normalizedBounds(minFraction: minFraction, maxFraction: maxFraction)

        guard fraction.isFinite else {
            return bounds.min
        }

        return min(max(fraction, bounds.min), bounds.max)
    }

    /// Returns layout-safe split bounds.
    public static func normalizedBounds(
        minFraction: CGFloat,
        maxFraction: CGFloat
    ) -> (min: CGFloat, max: CGFloat) {
        guard minFraction.isFinite, maxFraction.isFinite else {
            return (0.2, 0.8)
        }

        let lower = min(max(minFraction, 0.05), 0.95)
        let upper = min(max(maxFraction, 0.05), 0.95)

        guard lower < upper else {
            return (0.2, 0.8)
        }

        return (lower, upper)
    }

    private var currentFraction: CGFloat {
        externalFraction?.wrappedValue ?? internalFraction
    }

    private func resizeHandle(availableLength: CGFloat) -> some View {
        Rectangle()
            .fill(Color.clear)
            .frame(
                width: axis == .horizontal ? handleThickness : nil,
                height: axis == .vertical ? handleThickness : nil
            )
            .overlay {
                RoundedRectangle(cornerRadius: 999)
                    .fill(theme.colors.border.color)
                    .frame(
                        width: axis == .horizontal ? 2 : 36,
                        height: axis == .horizontal ? 36 : 2
                    )
            }
            .contentShape(Rectangle())
            .gesture(resizeGesture(availableLength: availableLength))
            .accessibilityElement()
            .accessibilityLabel("Resize panels")
            .accessibilityValue("\(Int(currentFraction * 100)) percent")
            .accessibilityHint("Drag to resize the panels")
            .accessibilityAdjustableAction { direction in
                let delta: CGFloat = direction == .increment ? 0.05 : -0.05
                setFraction(currentFraction + delta)
            }
    }

    private func resizeGesture(availableLength: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                guard availableLength > 0 else {
                    return
                }

                let startingFraction = dragStartFraction ?? currentFraction
                dragStartFraction = startingFraction

                let delta = axis == .horizontal ? value.translation.width : value.translation.height
                setFraction(startingFraction + delta / availableLength)
            }
            .onEnded { _ in
                dragStartFraction = nil
            }
    }

    private func setFraction(_ fraction: CGFloat) {
        let nextFraction = Self.normalizedFraction(fraction, minFraction: minFraction, maxFraction: maxFraction)

        if let externalFraction {
            externalFraction.wrappedValue = nextFraction
        } else {
            internalFraction = nextFraction
        }
    }

    private static func normalizedLength(_ length: CGFloat, fallback: CGFloat) -> CGFloat {
        guard length.isFinite, length > 0 else {
            return fallback
        }

        return length
    }
}
