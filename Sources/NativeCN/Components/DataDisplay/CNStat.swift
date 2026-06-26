import SwiftUI

/// A compact metric card for dashboards and summaries.
public struct CNStat<Accessory: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let value: String
    private let detail: String?
    private let trend: String?
    private let accessory: Accessory

    /// Creates a stat card.
    public init(
        _ title: String,
        value: String,
        detail: String? = nil,
        trend: String? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.title = title
        self.value = value
        self.detail = detail
        self.trend = trend
        self.accessory = accessory()
    }

    /// The stat body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x3) {
            HStack(alignment: .top, spacing: theme.space.x3) {
                VStack(alignment: .leading, spacing: theme.space.x1) {
                    Text(title)
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)

                    Text(value)
                        .font(theme.typography.title2.font.weight(.semibold))
                        .foregroundStyle(theme.colors.foreground.color)
                        .contentTransition(.numericText())
                }

                Spacer(minLength: theme.space.x3)

                accessory
            }

            if detail != nil || trend != nil {
                HStack(spacing: theme.space.x2) {
                    if let trend {
                        Text(trend)
                            .font(theme.typography.caption.font.weight(.medium))
                            .foregroundStyle(theme.colors.primary.color)
                    }

                    if let detail {
                        Text(detail)
                            .font(theme.typography.caption.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }
            }
        }
        .padding(theme.space.x4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        .accessibilityElement(children: .combine)
    }
}

public extension CNStat where Accessory == EmptyView {
    /// Creates a stat without accessory content.
    init(_ title: String, value: String, detail: String? = nil, trend: String? = nil) {
        self.init(title, value: value, detail: detail, trend: trend) {
            EmptyView()
        }
    }
}
