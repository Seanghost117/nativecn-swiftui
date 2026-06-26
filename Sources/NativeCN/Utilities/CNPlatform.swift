/// Apple platform information used by NativeCN components.
public enum CNPlatform: String, Sendable, Equatable {
    /// iOS.
    case iOS

    /// macOS.
    case macOS

    /// tvOS.
    case tvOS

    /// watchOS.
    case watchOS

    /// visionOS.
    case visionOS

    /// Unknown or unsupported platform.
    case unknown

    /// The platform currently compiling NativeCN.
    public static var current: CNPlatform {
        #if os(iOS)
        return .iOS
        #elseif os(macOS)
        return .macOS
        #elseif os(tvOS)
        return .tvOS
        #elseif os(watchOS)
        return .watchOS
        #elseif os(visionOS)
        return .visionOS
        #else
        return .unknown
        #endif
    }

    /// Whether the current platform commonly supports pointer hover.
    public static var supportsHover: Bool {
        #if os(iOS) || os(macOS) || os(visionOS)
        return true
        #else
        return false
        #endif
    }

    /// Whether the current platform commonly supports keyboard focus.
    public static var supportsKeyboardFocus: Bool {
        #if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
        return true
        #else
        return false
        #endif
    }

    /// Whether the current platform is primarily touch-based.
    public static var isTouchPrimary: Bool {
        #if os(iOS) || os(watchOS) || os(visionOS)
        return true
        #else
        return false
        #endif
    }
}
