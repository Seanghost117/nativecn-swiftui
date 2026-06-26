public extension CNTheme {
    /// The default light NativeCN theme.
    static let nativeCNLight = Self(
        colors: .nativeCNLight,
        typography: .default,
        radius: .derived(from: 10),
        space: .default,
        shadows: .default,
        motion: .default
    )

    /// The default dark NativeCN theme.
    static let nativeCNDark = Self(
        colors: .nativeCNDark,
        typography: .default,
        radius: .derived(from: 10),
        space: .default,
        shadows: .default,
        motion: .default
    )

    /// The default NativeCN theme used when no provider is installed.
    static let `default` = nativeCNLight
}

public extension CNColorTokens {
    /// The default light NativeCN semantic color tokens.
    static let nativeCNLight = Self(
        background: CNColorToken(hex: 0xFFFFFF),
        foreground: CNColorToken(hex: 0x09090B),
        card: CNColorToken(hex: 0xFFFFFF),
        cardForeground: CNColorToken(hex: 0x09090B),
        popover: CNColorToken(hex: 0xFFFFFF),
        popoverForeground: CNColorToken(hex: 0x09090B),
        primary: CNColorToken(hex: 0x18181B),
        primaryForeground: CNColorToken(hex: 0xFAFAFA),
        secondary: CNColorToken(hex: 0xF4F4F5),
        secondaryForeground: CNColorToken(hex: 0x18181B),
        muted: CNColorToken(hex: 0xF4F4F5),
        mutedForeground: CNColorToken(hex: 0x71717A),
        accent: CNColorToken(hex: 0xF4F4F5),
        accentForeground: CNColorToken(hex: 0x18181B),
        destructive: CNColorToken(hex: 0xDC2626),
        destructiveForeground: CNColorToken(hex: 0xFAFAFA),
        border: CNColorToken(hex: 0xE4E4E7),
        input: CNColorToken(hex: 0xE4E4E7),
        ring: CNColorToken(hex: 0x18181B),
        chart1: CNColorToken(hex: 0xE76E50),
        chart2: CNColorToken(hex: 0x2A9D90),
        chart3: CNColorToken(hex: 0x274754),
        chart4: CNColorToken(hex: 0xE8C468),
        chart5: CNColorToken(hex: 0xF4A462)
    )

    /// The default dark NativeCN semantic color tokens.
    static let nativeCNDark = Self(
        background: CNColorToken(hex: 0x09090B),
        foreground: CNColorToken(hex: 0xFAFAFA),
        card: CNColorToken(hex: 0x09090B),
        cardForeground: CNColorToken(hex: 0xFAFAFA),
        popover: CNColorToken(hex: 0x09090B),
        popoverForeground: CNColorToken(hex: 0xFAFAFA),
        primary: CNColorToken(hex: 0xFAFAFA),
        primaryForeground: CNColorToken(hex: 0x18181B),
        secondary: CNColorToken(hex: 0x27272A),
        secondaryForeground: CNColorToken(hex: 0xFAFAFA),
        muted: CNColorToken(hex: 0x27272A),
        mutedForeground: CNColorToken(hex: 0xA1A1AA),
        accent: CNColorToken(hex: 0x27272A),
        accentForeground: CNColorToken(hex: 0xFAFAFA),
        destructive: CNColorToken(hex: 0x7F1D1D),
        destructiveForeground: CNColorToken(hex: 0xFAFAFA),
        border: CNColorToken(hex: 0x27272A),
        input: CNColorToken(hex: 0x27272A),
        ring: CNColorToken(hex: 0xD4D4D8),
        chart1: CNColorToken(hex: 0x2662D9),
        chart2: CNColorToken(hex: 0x2EB88A),
        chart3: CNColorToken(hex: 0xE88C30),
        chart4: CNColorToken(hex: 0xAF57DB),
        chart5: CNColorToken(hex: 0xE23670)
    )
}
