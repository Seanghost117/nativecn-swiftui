import SwiftUI

/// A semantic Dynamic Type-compatible font token.
public struct CNFontToken: Sendable, Equatable {
    /// Apple text style represented by this token.
    public var textStyle: CNFontTextStyle

    /// Optional symbolic weight override.
    public var weight: CNFontWeight?

    /// Font design used by the token.
    public var design: CNFontDesign

    /// Creates a font token.
    public init(textStyle: CNFontTextStyle, weight: CNFontWeight? = nil, design: CNFontDesign = .default) {
        self.textStyle = textStyle
        self.weight = weight
        self.design = design
    }

    /// The SwiftUI font represented by this token.
    public var font: Font {
        var font = Font.system(textStyle.swiftUIStyle, design: design.swiftUIDesign)
        if let weight {
            font = font.weight(weight.swiftUIWeight)
        }
        return font
    }
}

/// Dynamic Type text styles supported by NativeCN typography tokens.
public enum CNFontTextStyle: String, Sendable, Equatable {
    /// Large title text.
    case largeTitle

    /// First-level title text.
    case title1

    /// Second-level title text.
    case title2

    /// Third-level title text.
    case title3

    /// Headline text.
    case headline

    /// Body text.
    case body

    /// Callout text.
    case callout

    /// Subheadline text.
    case subheadline

    /// Footnote text.
    case footnote

    /// Caption text.
    case caption

    var swiftUIStyle: Font.TextStyle {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title1:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .body:
            return .body
        case .callout:
            return .callout
        case .subheadline:
            return .subheadline
        case .footnote:
            return .footnote
        case .caption:
            return .caption
        }
    }
}

/// Symbolic font weights used by NativeCN typography tokens.
public enum CNFontWeight: String, Sendable, Equatable {
    /// Regular system weight.
    case regular

    /// Medium system weight.
    case medium

    /// Semibold system weight.
    case semibold

    /// Bold system weight.
    case bold

    var swiftUIWeight: Font.Weight {
        switch self {
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        case .bold:
            return .bold
        }
    }
}

/// System font designs supported by NativeCN typography tokens.
public enum CNFontDesign: String, Sendable, Equatable {
    /// Default Apple system font design.
    case `default`

    /// Rounded Apple system font design.
    case rounded

    /// Monospaced Apple system font design.
    case monospaced

    var swiftUIDesign: Font.Design {
        switch self {
        case .default:
            return .default
        case .rounded:
            return .rounded
        case .monospaced:
            return .monospaced
        }
    }
}

/// Typography tokens used by NativeCN components.
public struct CNTypographyTokens: Sendable, Equatable {
    /// Large title font token.
    public var largeTitle: CNFontToken

    /// First-level title font token.
    public var title1: CNFontToken

    /// Second-level title font token.
    public var title2: CNFontToken

    /// Third-level title font token.
    public var title3: CNFontToken

    /// Headline font token.
    public var headline: CNFontToken

    /// Body font token.
    public var body: CNFontToken

    /// Callout font token.
    public var callout: CNFontToken

    /// Subheadline font token.
    public var subheadline: CNFontToken

    /// Footnote font token.
    public var footnote: CNFontToken

    /// Caption font token.
    public var caption: CNFontToken

    /// Monospaced body font token.
    public var mono: CNFontToken

    /// Creates a typography token set.
    public init(
        largeTitle: CNFontToken,
        title1: CNFontToken,
        title2: CNFontToken,
        title3: CNFontToken,
        headline: CNFontToken,
        body: CNFontToken,
        callout: CNFontToken,
        subheadline: CNFontToken,
        footnote: CNFontToken,
        caption: CNFontToken,
        mono: CNFontToken
    ) {
        self.largeTitle = largeTitle
        self.title1 = title1
        self.title2 = title2
        self.title3 = title3
        self.headline = headline
        self.body = body
        self.callout = callout
        self.subheadline = subheadline
        self.footnote = footnote
        self.caption = caption
        self.mono = mono
    }
}

public extension CNTypographyTokens {
    /// Default Dynamic Type-compatible Apple system typography tokens.
    static let `default` = Self(
        largeTitle: CNFontToken(textStyle: .largeTitle, weight: .bold),
        title1: CNFontToken(textStyle: .title1, weight: .bold),
        title2: CNFontToken(textStyle: .title2, weight: .semibold),
        title3: CNFontToken(textStyle: .title3, weight: .semibold),
        headline: CNFontToken(textStyle: .headline, weight: .semibold),
        body: CNFontToken(textStyle: .body),
        callout: CNFontToken(textStyle: .callout),
        subheadline: CNFontToken(textStyle: .subheadline),
        footnote: CNFontToken(textStyle: .footnote),
        caption: CNFontToken(textStyle: .caption),
        mono: CNFontToken(textStyle: .body, design: .monospaced)
    )
}
