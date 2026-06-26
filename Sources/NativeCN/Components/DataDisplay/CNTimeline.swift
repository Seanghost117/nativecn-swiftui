import SwiftUI

/// An event item for `CNTimeline`.
public struct CNTimelineItem: Identifiable, Sendable, Equatable {
    /// Item identifier.
    public var id: String

    /// Event title.
    public var title: String

    /// Optional event detail.
    public var detail: String?

    /// Optional timestamp or relative time.
    public var timestamp: String?

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Creates a timeline item.
    public init(id: String, title: String, detail: String? = nil, timestamp: String? = nil, systemImage: String? = nil) {
        self.id = id
        self.title = title
        self.detail = detail
        self.timestamp = timestamp
        self.systemImage = systemImage
    }
}

/// A vertical activity timeline.
public struct CNTimeline: View {
    @Environment(\.cnTheme) private var theme

    private let items: [CNTimelineItem]

    /// Creates a timeline.
    public init(_ items: [CNTimelineItem]) {
        self.items = items
    }

    /// The timeline body.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                HStack(alignment: .top, spacing: theme.space.x3) {
                    VStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .fill(theme.colors.background.color)
                                .frame(width: 28, height: 28)
                                .cnBorder(color: theme.colors.border, cornerRadius: 14)

                            Image(systemName: item.systemImage ?? "circle.fill")
                                .font(.system(size: item.systemImage == nil ? 6 : 12, weight: .semibold))
                                .foregroundStyle(theme.colors.mutedForeground.color)
                                .accessibilityHidden(true)
                        }

                        if index < items.count - 1 {
                            Rectangle()
                                .fill(theme.colors.border.color)
                                .frame(width: 1)
                                .frame(maxHeight: .infinity)
                        }
                    }

                    VStack(alignment: .leading, spacing: theme.space.x1) {
                        HStack(alignment: .firstTextBaseline, spacing: theme.space.x3) {
                            Text(item.title)
                                .font(theme.typography.subheadline.font.weight(.medium))
                                .foregroundStyle(theme.colors.foreground.color)

                            Spacer(minLength: theme.space.x2)

                            if let timestamp = item.timestamp {
                                Text(timestamp)
                                    .font(theme.typography.caption.font)
                                    .foregroundStyle(theme.colors.mutedForeground.color)
                            }
                        }

                        if let detail = item.detail {
                            Text(detail)
                                .font(theme.typography.subheadline.font)
                                .foregroundStyle(theme.colors.mutedForeground.color)
                        }
                    }
                    .padding(.bottom, index < items.count - 1 ? theme.space.x5 : 0)
                    .accessibilityElement(children: .combine)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
