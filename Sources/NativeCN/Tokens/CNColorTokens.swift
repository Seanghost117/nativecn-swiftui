/// Semantic color tokens used by NativeCN components.
public struct CNColorTokens: Sendable, Equatable {
    /// Primary app background.
    public var background: CNColorToken

    /// Foreground content on the primary app background.
    public var foreground: CNColorToken

    /// Card and grouped-surface background.
    public var card: CNColorToken

    /// Foreground content on card surfaces.
    public var cardForeground: CNColorToken

    /// Popover, menu, and floating-surface background.
    public var popover: CNColorToken

    /// Foreground content on popover surfaces.
    public var popoverForeground: CNColorToken

    /// Primary interactive/accent color.
    public var primary: CNColorToken

    /// Foreground content on primary surfaces.
    public var primaryForeground: CNColorToken

    /// Secondary interactive/surface color.
    public var secondary: CNColorToken

    /// Foreground content on secondary surfaces.
    public var secondaryForeground: CNColorToken

    /// Muted surface color.
    public var muted: CNColorToken

    /// Lower-emphasis foreground color.
    public var mutedForeground: CNColorToken

    /// Accent surface color.
    public var accent: CNColorToken

    /// Foreground content on accent surfaces.
    public var accentForeground: CNColorToken

    /// Destructive action or error color.
    public var destructive: CNColorToken

    /// Foreground content on destructive surfaces.
    public var destructiveForeground: CNColorToken?

    /// Border and separator color.
    public var border: CNColorToken

    /// Input background or border color.
    public var input: CNColorToken

    /// Focus ring color.
    public var ring: CNColorToken

    /// First chart accent color.
    public var chart1: CNColorToken

    /// Second chart accent color.
    public var chart2: CNColorToken

    /// Third chart accent color.
    public var chart3: CNColorToken

    /// Fourth chart accent color.
    public var chart4: CNColorToken

    /// Fifth chart accent color.
    public var chart5: CNColorToken

    /// Creates a complete semantic color token set.
    public init(
        background: CNColorToken,
        foreground: CNColorToken,
        card: CNColorToken,
        cardForeground: CNColorToken,
        popover: CNColorToken,
        popoverForeground: CNColorToken,
        primary: CNColorToken,
        primaryForeground: CNColorToken,
        secondary: CNColorToken,
        secondaryForeground: CNColorToken,
        muted: CNColorToken,
        mutedForeground: CNColorToken,
        accent: CNColorToken,
        accentForeground: CNColorToken,
        destructive: CNColorToken,
        destructiveForeground: CNColorToken?,
        border: CNColorToken,
        input: CNColorToken,
        ring: CNColorToken,
        chart1: CNColorToken,
        chart2: CNColorToken,
        chart3: CNColorToken,
        chart4: CNColorToken,
        chart5: CNColorToken
    ) {
        self.background = background
        self.foreground = foreground
        self.card = card
        self.cardForeground = cardForeground
        self.popover = popover
        self.popoverForeground = popoverForeground
        self.primary = primary
        self.primaryForeground = primaryForeground
        self.secondary = secondary
        self.secondaryForeground = secondaryForeground
        self.muted = muted
        self.mutedForeground = mutedForeground
        self.accent = accent
        self.accentForeground = accentForeground
        self.destructive = destructive
        self.destructiveForeground = destructiveForeground
        self.border = border
        self.input = input
        self.ring = ring
        self.chart1 = chart1
        self.chart2 = chart2
        self.chart3 = chart3
        self.chart4 = chart4
        self.chart5 = chart5
    }
}
