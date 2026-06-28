import SwiftUI

/// Text and layout direction values.
public enum CNDirection: String, CaseIterable, Sendable, Equatable {
    /// Left-to-right layout.
    case ltr

    /// Right-to-left layout.
    case rtl

    var layoutDirection: LayoutDirection {
        switch self {
        case .ltr:
            return .leftToRight
        case .rtl:
            return .rightToLeft
        }
    }
}

/// Applies a layout direction to a subtree.
public struct CNDirectionProvider<Content: View>: View {
    private let direction: CNDirection
    private let content: Content

    /// Creates a direction provider.
    public init(_ direction: CNDirection, @ViewBuilder content: () -> Content) {
        self.direction = direction
        self.content = content()
    }

    /// The provider body.
    public var body: some View {
        content
            .environment(\.layoutDirection, direction.layoutDirection)
    }
}

public extension View {
    /// Applies a NativeCN direction to this view subtree.
    func cnDirection(_ direction: CNDirection) -> some View {
        environment(\.layoutDirection, direction.layoutDirection)
    }
}

