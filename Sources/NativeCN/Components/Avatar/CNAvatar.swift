import SwiftUI

/// A token-driven avatar with image, remote URL, initials, and placeholder fallback support.
public struct CNAvatar: View {
    /// Avatar size scale.
    public enum Size: String, CaseIterable, Sendable, Equatable {
        /// Small avatar.
        case sm

        /// Medium avatar.
        case md

        /// Large avatar.
        case lg

        /// Extra-large avatar.
        case xl

        /// Side length for this avatar size.
        public var length: CGFloat {
            switch self {
            case .sm:
                return 32
            case .md:
                return 40
            case .lg:
                return 56
            case .xl:
                return 72
            }
        }

        /// Font token style for fallback initials.
        public var textStyle: CNFontTextStyle {
            switch self {
            case .sm, .md:
                return .caption
            case .lg:
                return .headline
            case .xl:
                return .title3
            }
        }
    }

    @Environment(\.cnTheme) private var theme

    private let image: Image?
    private let url: URL?
    private let fallback: String?
    private let size: Size
    private let accessibilityLabel: String?

    /// Creates an avatar backed by a remote URL.
    public init(url: URL?, fallback: String? = nil, size: Size = .md, accessibilityLabel: String? = nil) {
        self.image = nil
        self.url = url
        self.fallback = fallback
        self.size = size
        self.accessibilityLabel = accessibilityLabel
    }

    /// Creates an avatar backed by a local SwiftUI image.
    public init(image: Image, fallback: String? = nil, size: Size = .md, accessibilityLabel: String? = nil) {
        self.image = image
        self.url = nil
        self.fallback = fallback
        self.size = size
        self.accessibilityLabel = accessibilityLabel
    }

    /// Creates an avatar that shows fallback initials or a placeholder.
    public init(fallback: String? = nil, size: Size = .md, accessibilityLabel: String? = nil) {
        self.image = nil
        self.url = nil
        self.fallback = fallback
        self.size = size
        self.accessibilityLabel = accessibilityLabel
    }

    /// The avatar body.
    public var body: some View {
        avatarContent
            .frame(width: size.length, height: size.length)
            .clipShape(Circle())
            .background {
                Circle()
                    .fill(theme.colors.muted.color)
            }
            .overlay {
                Circle()
                    .stroke(theme.colors.border.color, lineWidth: 1)
            }
            .accessibilityLabel(accessibilityLabel ?? fallback ?? "Avatar")
    }

    @ViewBuilder
    private var avatarContent: some View {
        if let image {
            imageContent(image)
        } else if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case let .success(image):
                    imageContent(image)
                case .empty:
                    loadingFallback
                case .failure:
                    fallbackContent
                @unknown default:
                    fallbackContent
                }
            }
        } else {
            fallbackContent
        }
    }

    private func imageContent(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: size.length, height: size.length)
    }

    private var loadingFallback: some View {
        ZStack {
            theme.colors.muted.color
            CNSpinner(size: size.length * 0.36, label: "Loading avatar")
        }
    }

    @ViewBuilder
    private var fallbackContent: some View {
        if let initials = normalizedFallback {
            ZStack {
                theme.colors.muted.color
                Text(initials)
                    .font(CNFontToken(textStyle: size.textStyle, weight: .semibold).font)
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .minimumScaleFactor(0.7)
            }
        } else {
            ZStack {
                theme.colors.muted.color
                Image(systemName: "person.fill")
                    .font(.system(size: size.length * 0.42, weight: .medium))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .accessibilityHidden(true)
            }
        }
    }

    private var normalizedFallback: String? {
        guard let fallback else { return nil }
        let trimmed = fallback.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return String(trimmed.prefix(3)).uppercased()
    }
}
