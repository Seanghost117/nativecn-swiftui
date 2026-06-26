/// A complete NativeCN theme made from semantic design tokens.
public struct CNTheme: Sendable, Equatable {
    /// Semantic color tokens.
    public var colors: CNColorTokens

    /// Dynamic Type-compatible typography tokens.
    public var typography: CNTypographyTokens

    /// Radius tokens.
    public var radius: CNRadiusTokens

    /// Spacing tokens.
    public var space: CNSpaceTokens

    /// Shadow and elevation tokens.
    public var shadows: CNShadowTokens

    /// Motion tokens.
    public var motion: CNMotionTokens

    /// Creates a NativeCN theme.
    public init(
        colors: CNColorTokens,
        typography: CNTypographyTokens,
        radius: CNRadiusTokens,
        space: CNSpaceTokens,
        shadows: CNShadowTokens,
        motion: CNMotionTokens
    ) {
        self.colors = colors
        self.typography = typography
        self.radius = radius
        self.space = space
        self.shadows = shadows
        self.motion = motion
    }
}
