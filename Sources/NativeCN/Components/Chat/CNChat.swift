import SwiftUI

/// Chat message roles used by NativeCN chat components.
public enum CNMessageRole: String, CaseIterable, Sendable, Equatable {
    /// A message from the current user.
    case user

    /// A message from an assistant or service.
    case assistant

    /// A system or timeline message.
    case system

    /// A tool result or automation message.
    case tool
}

/// Delivery or generation status for a chat message.
public enum CNMessageStatus: String, CaseIterable, Sendable, Equatable {
    /// Message is being generated or sent.
    case streaming

    /// Message was sent.
    case sent

    /// Message was delivered.
    case delivered

    /// Message was read.
    case read

    /// Message failed.
    case failed

    /// Human-readable label for this status.
    public var label: String {
        switch self {
        case .streaming:
            return "Streaming"
        case .sent:
            return "Sent"
        case .delivered:
            return "Delivered"
        case .read:
            return "Read"
        case .failed:
            return "Failed"
        }
    }
}

/// Attachment metadata for chat messages.
public struct CNAttachment: Identifiable, Sendable, Equatable {
    /// Attachment identifier.
    public var id: String

    /// Attachment title.
    public var title: String

    /// Optional subtitle.
    public var subtitle: String?

    /// Optional metadata such as file size.
    public var metadata: String?

    /// Optional SF Symbol.
    public var systemImage: String

    /// Creates an attachment.
    public init(
        id: String,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        systemImage: String = "paperclip"
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.metadata = metadata
        self.systemImage = systemImage
    }
}

/// A rendered attachment row for chat bubbles.
public struct CNAttachmentView: View {
    @Environment(\.cnTheme) private var theme

    private let attachment: CNAttachment

    /// Creates an attachment view.
    public init(_ attachment: CNAttachment) {
        self.attachment = attachment
    }

    /// The attachment view body.
    public var body: some View {
        HStack(spacing: theme.space.x3) {
            Image(systemName: attachment.systemImage)
                .font(.body.weight(.semibold))
                .foregroundStyle(theme.colors.mutedForeground.color)
                .frame(width: 30, height: 30)
                .background(theme.colors.muted.color)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.space.x1) {
                Text(attachment.title)
                    .font(theme.typography.subheadline.font.weight(.medium))
                    .foregroundStyle(theme.colors.foreground.color)
                    .lineLimit(1)

                if let subtitle = attachment.subtitle {
                    Text(subtitle)
                        .font(theme.typography.caption.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: theme.space.x2)

            if let metadata = attachment.metadata {
                Text(metadata)
                    .font(theme.typography.caption.font)
                    .foregroundStyle(theme.colors.mutedForeground.color)
            }
        }
        .padding(theme.space.x3)
        .background(theme.colors.background.color.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.md)
        .accessibilityElement(children: .combine)
    }
}

/// A tokenized chat bubble.
public struct CNBubble<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let role: CNMessageRole
    private let maxWidthFraction: Double
    private let content: Content

    /// Creates a chat bubble.
    public init(
        role: CNMessageRole = .assistant,
        maxWidthFraction: Double = 0.78,
        @ViewBuilder content: () -> Content
    ) {
        self.role = role
        self.maxWidthFraction = Self.normalizedMaxWidthFraction(maxWidthFraction)
        self.content = content()
    }

    /// The bubble body.
    public var body: some View {
        content
            .font(theme.typography.body.font)
            .foregroundStyle(style.foreground.color)
            .padding(.horizontal, theme.space.x4)
            .padding(.vertical, theme.space.x3)
            .background(style.background.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.xl))
            .cnBorder(color: style.border, lineWidth: style.borderWidth, cornerRadius: theme.radius.xl)
            .frame(maxWidth: 640 * maxWidthFraction, alignment: role.messageAlignment)
            .accessibilityElement(children: .combine)
    }

    /// Normalizes bubble width into a readable range.
    public static func normalizedMaxWidthFraction(_ value: Double) -> Double {
        min(max(value, 0.42), 1)
    }

    private var style: CNBubbleStyleValues {
        role.bubbleStyle(in: theme)
    }
}

/// Resolved bubble style values.
public struct CNBubbleStyleValues: Sendable, Equatable {
    /// Bubble background.
    public var background: CNColorToken

    /// Bubble foreground.
    public var foreground: CNColorToken

    /// Bubble border.
    public var border: CNColorToken

    /// Bubble border width.
    public var borderWidth: CGFloat

    /// Creates bubble style values.
    public init(background: CNColorToken, foreground: CNColorToken, border: CNColorToken, borderWidth: CGFloat = 0) {
        self.background = background
        self.foreground = foreground
        self.border = border
        self.borderWidth = borderWidth
    }
}

public extension CNMessageRole {
    /// Resolves bubble style values for a message role.
    func bubbleStyle(in theme: CNTheme) -> CNBubbleStyleValues {
        let clear = CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)

        switch self {
        case .user:
            return CNBubbleStyleValues(background: theme.colors.primary, foreground: theme.colors.primaryForeground, border: clear)
        case .assistant:
            return CNBubbleStyleValues(background: theme.colors.muted, foreground: theme.colors.foreground, border: theme.colors.border, borderWidth: 1)
        case .system:
            return CNBubbleStyleValues(background: theme.colors.secondary, foreground: theme.colors.secondaryForeground, border: theme.colors.border, borderWidth: 1)
        case .tool:
            return CNBubbleStyleValues(background: theme.colors.accent, foreground: theme.colors.accentForeground, border: theme.colors.border, borderWidth: 1)
        }
    }

    var messageAlignment: Alignment {
        switch self {
        case .user:
            return .trailing
        case .assistant, .system, .tool:
            return .leading
        }
    }
}

/// A chat marker for dates, status changes, and tool boundaries.
public struct CNMarker: View {
    /// Marker variant.
    public enum Variant: String, CaseIterable, Sendable, Equatable {
        /// Date or timeline marker.
        case date

        /// Neutral status marker.
        case status

        /// Tool marker.
        case tool

        /// Error marker.
        case error
    }

    @Environment(\.cnTheme) private var theme

    private let title: String
    private let message: String?
    private let variant: Variant
    private let systemImage: String?

    /// Creates a marker.
    public init(_ title: String, message: String? = nil, variant: Variant = .status, systemImage: String? = nil) {
        self.title = title
        self.message = message
        self.variant = variant
        self.systemImage = systemImage
    }

    /// The marker body.
    public var body: some View {
        HStack(spacing: theme.space.x2) {
            line

            HStack(spacing: theme.space.x2) {
                if let imageName = systemImage ?? variant.defaultSystemImage {
                    Image(systemName: imageName)
                        .font(.caption.weight(.semibold))
                        .accessibilityHidden(true)
                }

                VStack(spacing: theme.space.x1) {
                    Text(title)
                        .font(theme.typography.caption.font.weight(.medium))

                    if let message {
                        Text(message)
                            .font(theme.typography.caption.font)
                    }
                }
            }
            .foregroundStyle(variant.foreground(in: theme).color)
            .padding(.horizontal, theme.space.x3)
            .padding(.vertical, theme.space.x2)
            .background(variant.background(in: theme).color)
            .clipShape(Capsule())
            .cnBorder(color: theme.colors.border, cornerRadius: 999)

            line
        }
        .accessibilityElement(children: .combine)
    }

    private var line: some View {
        Rectangle()
            .fill(theme.colors.border.color)
            .frame(height: 1)
    }
}

public extension CNMarker.Variant {
    /// Default SF Symbol for this marker variant.
    var defaultSystemImage: String? {
        switch self {
        case .date:
            return nil
        case .status:
            return "checkmark.circle"
        case .tool:
            return "wrench.and.screwdriver"
        case .error:
            return "exclamationmark.triangle"
        }
    }

    /// Resolves the marker foreground token.
    func foreground(in theme: CNTheme) -> CNColorToken {
        switch self {
        case .date, .status:
            return theme.colors.mutedForeground
        case .tool:
            return theme.colors.foreground
        case .error:
            return theme.colors.destructive
        }
    }

    /// Resolves the marker background token.
    func background(in theme: CNTheme) -> CNColorToken {
        switch self {
        case .date, .status:
            return theme.colors.background
        case .tool:
            return theme.colors.accent
        case .error:
            return theme.colors.background
        }
    }
}

/// A complete chat message row with optional avatar, metadata, attachments, and footer content.
public struct CNMessage<Content: View, Footer: View>: View {
    @Environment(\.cnTheme) private var theme

    private let role: CNMessageRole
    private let author: String?
    private let timestamp: String?
    private let status: CNMessageStatus?
    private let avatarFallback: String?
    private let attachments: [CNAttachment]
    private let content: Content
    private let footer: Footer

    /// Creates a chat message row.
    public init(
        role: CNMessageRole = .assistant,
        author: String? = nil,
        timestamp: String? = nil,
        status: CNMessageStatus? = nil,
        avatarFallback: String? = nil,
        attachments: [CNAttachment] = [],
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.role = role
        self.author = author
        self.timestamp = timestamp
        self.status = status
        self.avatarFallback = avatarFallback
        self.attachments = attachments
        self.content = content()
        self.footer = footer()
    }

    /// The message body.
    public var body: some View {
        HStack(alignment: .top, spacing: theme.space.x3) {
            if role != .user {
                avatar
            }

            messageColumn
                .frame(maxWidth: .infinity, alignment: role.messageAlignment)

            if role == .user {
                avatar
            }
        }
        .accessibilityElement(children: .contain)
    }

    private var messageColumn: some View {
        VStack(alignment: role == .user ? .trailing : .leading, spacing: theme.space.x2) {
            if author != nil || timestamp != nil {
                metadataRow
            }

            CNBubble(role: role) {
                VStack(alignment: .leading, spacing: theme.space.x3) {
                    content

                    if !attachments.isEmpty {
                        VStack(spacing: theme.space.x2) {
                            ForEach(attachments) { attachment in
                                CNAttachmentView(attachment)
                            }
                        }
                    }
                }
            }

            footerRow
        }
    }

    private var metadataRow: some View {
        HStack(spacing: theme.space.x2) {
            if let author {
                Text(author)
                    .font(theme.typography.caption.font.weight(.semibold))
                    .foregroundStyle(theme.colors.foreground.color)
            }

            if author != nil, timestamp != nil {
                Text("•")
                    .font(theme.typography.caption.font)
                    .foregroundStyle(theme.colors.mutedForeground.color)
            }

            if let timestamp {
                Text(timestamp)
                    .font(theme.typography.caption.font)
                    .foregroundStyle(theme.colors.mutedForeground.color)
            }
        }
    }

    @ViewBuilder
    private var footerRow: some View {
        if status != nil || Footer.self != EmptyView.self {
            HStack(spacing: theme.space.x2) {
                if let status {
                    Text(status.label)
                        .font(theme.typography.caption.font)
                        .foregroundStyle(status == .failed ? theme.colors.destructive.color : theme.colors.mutedForeground.color)
                }

                footer
            }
        }
    }

    @ViewBuilder
    private var avatar: some View {
        if let avatarFallback {
            CNAvatar(fallback: avatarFallback, size: .sm, accessibilityLabel: author)
        } else {
            Spacer()
                .frame(width: CNAvatar.Size.sm.length, height: CNAvatar.Size.sm.length)
        }
    }
}

public extension CNMessage where Footer == EmptyView {
    /// Creates a chat message row without footer content.
    init(
        role: CNMessageRole = .assistant,
        author: String? = nil,
        timestamp: String? = nil,
        status: CNMessageStatus? = nil,
        avatarFallback: String? = nil,
        attachments: [CNAttachment] = [],
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            role: role,
            author: author,
            timestamp: timestamp,
            status: status,
            avatarFallback: avatarFallback,
            attachments: attachments,
            content: content
        ) {
            EmptyView()
        }
    }
}

/// A scroll container for chat transcripts.
public struct CNMessageScroller<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let anchorID: AnyHashable?
    private let showsIndicators: Bool
    private let minHeight: CGFloat?
    private let content: Content

    /// Creates a message scroller.
    public init(
        anchorID: AnyHashable? = nil,
        showsIndicators: Bool = true,
        minHeight: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.anchorID = anchorID
        self.showsIndicators = showsIndicators
        self.minHeight = minHeight
        self.content = content()
    }

    /// The scroller body.
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: showsIndicators) {
                LazyVStack(alignment: .leading, spacing: theme.space.x4) {
                    content

                    Color.clear
                        .frame(height: 1)
                        .id(bottomAnchorID)
                }
                .padding(theme.space.x4)
            }
            .frame(maxWidth: .infinity, minHeight: minHeight)
            .background(theme.colors.background.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
            .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
            .onAppear {
                scroll(proxy)
            }
            .onChange(of: anchorID) { _ in
                scroll(proxy)
            }
        }
    }

    private var bottomAnchorID: String {
        "cn-message-scroller-bottom"
    }

    private func scroll(_ proxy: ScrollViewProxy) {
        let target = anchorID ?? AnyHashable(bottomAnchorID)
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: 0.2)) {
                proxy.scrollTo(target, anchor: .bottom)
            }
        }
    }
}

