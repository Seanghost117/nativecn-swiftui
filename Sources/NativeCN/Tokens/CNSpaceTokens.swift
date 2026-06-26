import CoreGraphics

/// Spacing tokens used for NativeCN layout rhythm.
public struct CNSpaceTokens: Sendable, Equatable {
    /// Zero spacing.
    public var x0: CGFloat

    /// 1x spacing.
    public var x1: CGFloat

    /// 2x spacing.
    public var x2: CGFloat

    /// 3x spacing.
    public var x3: CGFloat

    /// 4x spacing.
    public var x4: CGFloat

    /// 5x spacing.
    public var x5: CGFloat

    /// 6x spacing.
    public var x6: CGFloat

    /// 8x spacing.
    public var x8: CGFloat

    /// 10x spacing.
    public var x10: CGFloat

    /// 12x spacing.
    public var x12: CGFloat

    /// 16x spacing.
    public var x16: CGFloat

    /// Creates a spacing token set.
    public init(
        x0: CGFloat,
        x1: CGFloat,
        x2: CGFloat,
        x3: CGFloat,
        x4: CGFloat,
        x5: CGFloat,
        x6: CGFloat,
        x8: CGFloat,
        x10: CGFloat,
        x12: CGFloat,
        x16: CGFloat
    ) {
        self.x0 = x0
        self.x1 = x1
        self.x2 = x2
        self.x3 = x3
        self.x4 = x4
        self.x5 = x5
        self.x6 = x6
        self.x8 = x8
        self.x10 = x10
        self.x12 = x12
        self.x16 = x16
    }
}

public extension CNSpaceTokens {
    /// The default NativeCN spacing scale.
    static let `default` = Self(
        x0: 0,
        x1: 4,
        x2: 8,
        x3: 12,
        x4: 16,
        x5: 20,
        x6: 24,
        x8: 32,
        x10: 40,
        x12: 48,
        x16: 64
    )
}
