import SwiftUI

/// A platform-neutral color token that can be converted to SwiftUI `Color`.
public struct CNColorToken: Sendable, Equatable {
    /// Red channel in the `0...1` range.
    public var red: Double

    /// Green channel in the `0...1` range.
    public var green: Double

    /// Blue channel in the `0...1` range.
    public var blue: Double

    /// Opacity channel in the `0...1` range.
    public var opacity: Double

    /// Creates a color token from normalized RGBA channel values.
    public init(red: Double, green: Double, blue: Double, opacity: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    /// Creates a color token from an RGB hex value.
    public init(hex: UInt32, opacity: Double = 1) {
        self.red = Double((hex >> 16) & 0xFF) / 255
        self.green = Double((hex >> 8) & 0xFF) / 255
        self.blue = Double(hex & 0xFF) / 255
        self.opacity = opacity
    }

    /// The SwiftUI color represented by this token.
    public var color: Color {
        Color(
            red: red,
            green: green,
            blue: blue,
            opacity: opacity
        )
    }
}

public extension Color {
    /// Creates a SwiftUI color from a NativeCN color token.
    init(cn token: CNColorToken) {
        self = token.color
    }
}
