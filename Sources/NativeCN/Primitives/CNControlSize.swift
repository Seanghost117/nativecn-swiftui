import CoreGraphics

/// Standard NativeCN control sizes used by buttons, inputs, and compact controls.
public enum CNControlSize: String, CaseIterable, Sendable, Equatable {
    /// Small control size.
    case sm

    /// Default medium control size.
    case md

    /// Large control size.
    case lg

    /// Square icon-only control size.
    case icon

    /// Returns token-derived metrics for this control size.
    public func metrics(in theme: CNTheme) -> CNControlSizeMetrics {
        switch self {
        case .sm:
            return CNControlSizeMetrics(
                height: 30,
                minWidth: 30,
                horizontalPadding: theme.space.x3,
                verticalPadding: theme.space.x0,
                iconLength: 14,
                spacing: theme.space.x2,
                cornerRadius: theme.radius.sm
            )
        case .md:
            return CNControlSizeMetrics(
                height: 36,
                minWidth: 36,
                horizontalPadding: theme.space.x3,
                verticalPadding: theme.space.x0,
                iconLength: 16,
                spacing: theme.space.x2,
                cornerRadius: theme.radius.md
            )
        case .lg:
            return CNControlSizeMetrics(
                height: 42,
                minWidth: 42,
                horizontalPadding: theme.space.x4,
                verticalPadding: theme.space.x0,
                iconLength: 18,
                spacing: theme.space.x3,
                cornerRadius: theme.radius.lg
            )
        case .icon:
            return CNControlSizeMetrics(
                height: 36,
                minWidth: 36,
                horizontalPadding: theme.space.x2,
                verticalPadding: theme.space.x0,
                iconLength: 16,
                spacing: theme.space.x0,
                cornerRadius: theme.radius.md
            )
        }
    }
}

/// Token-derived measurements for a NativeCN control size.
public struct CNControlSizeMetrics: Sendable, Equatable {
    /// Recommended control height.
    public var height: CGFloat

    /// Recommended minimum control width.
    public var minWidth: CGFloat

    /// Recommended horizontal padding.
    public var horizontalPadding: CGFloat

    /// Recommended vertical padding.
    public var verticalPadding: CGFloat

    /// Recommended icon side length.
    public var iconLength: CGFloat

    /// Recommended spacing between inline control content.
    public var spacing: CGFloat

    /// Recommended corner radius.
    public var cornerRadius: CGFloat

    /// Creates control size metrics.
    public init(
        height: CGFloat,
        minWidth: CGFloat,
        horizontalPadding: CGFloat,
        verticalPadding: CGFloat,
        iconLength: CGFloat,
        spacing: CGFloat,
        cornerRadius: CGFloat
    ) {
        self.height = height
        self.minWidth = minWidth
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.iconLength = iconLength
        self.spacing = spacing
        self.cornerRadius = cornerRadius
    }
}
