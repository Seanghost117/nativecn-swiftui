import SwiftUI

/// A token-driven loading placeholder.
public struct CNSkeleton: View {
    /// Skeleton shape.
    public enum Shape: String, CaseIterable, Sendable, Equatable {
        /// Rectangle skeleton.
        case rectangle

        /// Rounded rectangle skeleton.
        case roundedRectangle

        /// Circular skeleton.
        case circle
    }

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.cnTheme) private var theme
    @State private var shimmerOffset: CGFloat = -1

    private let width: CGFloat?
    private let height: CGFloat?
    private let shape: Shape
    private let shimmer: Bool
    private let label: String

    /// Creates a skeleton placeholder.
    public init(width: CGFloat? = nil, height: CGFloat? = nil, shape: Shape = .roundedRectangle, shimmer: Bool = true, label: String = "Loading") {
        self.width = width
        self.height = height
        self.shape = shape
        self.shimmer = shimmer
        self.label = label
    }

    /// Creates a square or circular skeleton placeholder.
    public init(shape: Shape, size: CGFloat, shimmer: Bool = true, label: String = "Loading") {
        self.width = size
        self.height = size
        self.shape = shape
        self.shimmer = shimmer
        self.label = label
    }

    /// The skeleton body.
    public var body: some View {
        skeletonShape
            .fill(theme.colors.muted.color)
            .overlay {
                if shimmer && !reduceMotion {
                    skeletonShape
                        .fill(shimmerGradient)
                        .mask(skeletonShape)
                        .onAppear {
                            shimmerOffset = 1
                        }
                        .animation(
                            .linear(duration: theme.motion.slow * 4).repeatForever(autoreverses: false),
                            value: shimmerOffset
                        )
                }
            }
            .frame(width: width, height: height ?? defaultHeight)
            .accessibilityLabel(label)
    }

    private var defaultHeight: CGFloat {
        switch shape {
        case .rectangle, .roundedRectangle:
            return 20
        case .circle:
            return width ?? 40
        }
    }

    private var shimmerGradient: LinearGradient {
        LinearGradient(
            colors: [
                theme.colors.muted.color.opacity(0),
                theme.colors.accent.color.opacity(0.75),
                theme.colors.muted.color.opacity(0),
            ],
            startPoint: UnitPoint(x: shimmerOffset - 0.6, y: 0.5),
            endPoint: UnitPoint(x: shimmerOffset, y: 0.5)
        )
    }

    private var skeletonShape: AnyShape {
        switch shape {
        case .rectangle:
            return AnyShape(Rectangle())
        case .roundedRectangle:
            return AnyShape(RoundedRectangle(cornerRadius: theme.radius.md))
        case .circle:
            return AnyShape(Circle())
        }
    }
}

private struct AnyShape: Shape {
    private let pathBuilder: @Sendable (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        self.pathBuilder = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        pathBuilder(rect)
    }
}
