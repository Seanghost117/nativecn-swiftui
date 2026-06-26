import CoreGraphics

/// Corner radius tokens used by NativeCN surfaces and controls.
public struct CNRadiusTokens: Sendable, Equatable {
    /// Small radius.
    public var sm: CGFloat

    /// Medium radius.
    public var md: CGFloat

    /// Large radius.
    public var lg: CGFloat

    /// Extra-large radius.
    public var xl: CGFloat

    /// Double extra-large radius.
    public var x2l: CGFloat

    /// Triple extra-large radius.
    public var x3l: CGFloat

    /// Quadruple extra-large radius.
    public var x4l: CGFloat

    /// Creates a radius token set.
    public init(sm: CGFloat, md: CGFloat, lg: CGFloat, xl: CGFloat, x2l: CGFloat, x3l: CGFloat, x4l: CGFloat) {
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.x2l = x2l
        self.x3l = x3l
        self.x4l = x4l
    }
}

public extension CNRadiusTokens {
    /// Creates a radius scale derived from a single base value.
    static func derived(from base: CGFloat) -> Self {
        .init(
            sm: base * 0.6,
            md: base * 0.8,
            lg: base,
            xl: base * 1.4,
            x2l: base * 1.8,
            x3l: base * 2.2,
            x4l: base * 2.6
        )
    }
}
