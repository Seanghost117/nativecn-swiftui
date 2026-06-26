import CoreGraphics

/// A shadow token for NativeCN surfaces.
public struct CNShadowToken: Sendable, Equatable {
    /// Shadow color.
    public var color: CNColorToken

    /// Shadow blur radius.
    public var radius: CGFloat

    /// Horizontal shadow offset.
    public var x: CGFloat

    /// Vertical shadow offset.
    public var y: CGFloat

    /// Creates a shadow token.
    public init(color: CNColorToken, radius: CGFloat, x: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

/// Shadow and elevation tokens used by NativeCN surfaces.
public struct CNShadowTokens: Sendable, Equatable {
    /// No shadow.
    public var none: CNShadowToken

    /// Small elevation shadow.
    public var sm: CNShadowToken

    /// Medium elevation shadow.
    public var md: CNShadowToken

    /// Large elevation shadow.
    public var lg: CNShadowToken

    /// Popover elevation shadow.
    public var popover: CNShadowToken

    /// Sheet elevation shadow.
    public var sheet: CNShadowToken

    /// Creates a shadow token set.
    public init(
        none: CNShadowToken,
        sm: CNShadowToken,
        md: CNShadowToken,
        lg: CNShadowToken,
        popover: CNShadowToken,
        sheet: CNShadowToken
    ) {
        self.none = none
        self.sm = sm
        self.md = md
        self.lg = lg
        self.popover = popover
        self.sheet = sheet
    }
}

public extension CNShadowTokens {
    /// Default subtle NativeCN shadow tokens.
    static let `default` = Self(
        none: CNShadowToken(color: CNColorToken(red: 0, green: 0, blue: 0, opacity: 0), radius: 0, x: 0, y: 0),
        sm: CNShadowToken(color: CNColorToken(red: 0, green: 0, blue: 0, opacity: 0.08), radius: 2, x: 0, y: 1),
        md: CNShadowToken(color: CNColorToken(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 8, x: 0, y: 4),
        lg: CNShadowToken(color: CNColorToken(red: 0, green: 0, blue: 0, opacity: 0.12), radius: 16, x: 0, y: 8),
        popover: CNShadowToken(color: CNColorToken(red: 0, green: 0, blue: 0, opacity: 0.16), radius: 24, x: 0, y: 12),
        sheet: CNShadowToken(color: CNColorToken(red: 0, green: 0, blue: 0, opacity: 0.18), radius: 28, x: 0, y: 16)
    )
}
