import SwiftUI

/// A semantic animation token.
public struct CNAnimationToken: Sendable, Equatable {
    /// Animation curve.
    public var curve: CNAnimationCurve

    /// Animation duration in seconds.
    public var duration: Double

    /// Optional spring response.
    public var response: Double?

    /// Optional spring damping fraction.
    public var dampingFraction: Double?

    /// Creates an animation token.
    public init(curve: CNAnimationCurve, duration: Double, response: Double? = nil, dampingFraction: Double? = nil) {
        self.curve = curve
        self.duration = duration
        self.response = response
        self.dampingFraction = dampingFraction
    }

    /// Returns a SwiftUI animation unless Reduce Motion should suppress it.
    public func animation(reduceMotion: Bool = false) -> Animation? {
        guard !reduceMotion else { return nil }

        switch curve {
        case .easeIn:
            return .easeIn(duration: duration)
        case .easeOut:
            return .easeOut(duration: duration)
        case .easeInOut:
            return .easeInOut(duration: duration)
        case .linear:
            return .linear(duration: duration)
        case .spring:
            return .spring(
                response: response ?? duration,
                dampingFraction: dampingFraction ?? 0.82
            )
        }
    }
}

/// Animation curves supported by NativeCN motion tokens.
public enum CNAnimationCurve: String, Sendable, Equatable {
    /// Ease-in curve.
    case easeIn

    /// Ease-out curve.
    case easeOut

    /// Ease-in-out curve.
    case easeInOut

    /// Linear curve.
    case linear

    /// Spring curve.
    case spring
}

/// Motion tokens used by NativeCN interactions.
public struct CNMotionTokens: Sendable, Equatable {
    /// Fast animation duration in seconds.
    public var fast: Double

    /// Normal animation duration in seconds.
    public var normal: Double

    /// Slow animation duration in seconds.
    public var slow: Double

    /// Spring animation token.
    public var spring: CNAnimationToken

    /// Ease-out animation token.
    public var easeOut: CNAnimationToken

    /// Ease-in-out animation token.
    public var easeInOut: CNAnimationToken

    /// Creates a motion token set.
    public init(
        fast: Double,
        normal: Double,
        slow: Double,
        spring: CNAnimationToken,
        easeOut: CNAnimationToken,
        easeInOut: CNAnimationToken
    ) {
        self.fast = fast
        self.normal = normal
        self.slow = slow
        self.spring = spring
        self.easeOut = easeOut
        self.easeInOut = easeInOut
    }
}

public extension CNMotionTokens {
    /// Default restrained NativeCN motion tokens.
    static let `default` = Self(
        fast: 0.12,
        normal: 0.20,
        slow: 0.32,
        spring: CNAnimationToken(curve: .spring, duration: 0.28, response: 0.28, dampingFraction: 0.86),
        easeOut: CNAnimationToken(curve: .easeOut, duration: 0.20),
        easeInOut: CNAnimationToken(curve: .easeInOut, duration: 0.24)
    )
}
