import SwiftUI

/// A semantic chart series backed by the NativeCN chart color tokens.
public struct CNChartSeries: Identifiable, Sendable, Equatable {
    /// Series identifier.
    public var id: String

    /// Series display title.
    public var title: String

    /// Index into the theme chart color palette.
    public var colorIndex: Int

    /// Optional supporting description.
    public var detail: String?

    /// Creates a chart series.
    public init(id: String, title: String, colorIndex: Int = 0, detail: String? = nil) {
        self.id = id
        self.title = title
        self.colorIndex = colorIndex
        self.detail = detail
    }

    /// Resolves the chart series color token for a theme.
    public func color(in theme: CNTheme) -> CNColorToken {
        CNChartPalette.color(at: colorIndex, in: theme)
    }
}

/// Chart presentation state.
public enum CNChartState: Sendable, Equatable {
    /// Render chart content.
    case ready

    /// Render a loading placeholder.
    case loading

    /// Render an empty-state message.
    case empty(title: String, message: String?)

    /// Render an error-state message.
    case error(title: String, message: String?)
}

/// Helpers for resolving NativeCN chart colors.
public enum CNChartPalette {
    /// Resolves a chart color token by wrapping the provided index through the theme chart palette.
    public static func color(at index: Int, in theme: CNTheme) -> CNColorToken {
        let colors = [
            theme.colors.chart1,
            theme.colors.chart2,
            theme.colors.chart3,
            theme.colors.chart4,
            theme.colors.chart5,
        ]
        let normalizedIndex = ((index % colors.count) + colors.count) % colors.count
        return colors[normalizedIndex]
    }
}

/// A tokenized chart container with title, subtitle, state handling, and optional footer content.
public struct CNChartContainer<ChartContent: View, Footer: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String?
    private let subtitle: String?
    private let state: CNChartState
    private let height: CGFloat
    private let chartContent: ChartContent
    private let footer: Footer

    /// Creates a chart container.
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        state: CNChartState = .ready,
        height: CGFloat = 240,
        @ViewBuilder content: () -> ChartContent,
        @ViewBuilder footer: () -> Footer
    ) {
        self.title = title
        self.subtitle = subtitle
        self.state = state
        self.height = max(120, height)
        self.chartContent = content()
        self.footer = footer()
    }

    /// The chart container body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x4) {
            if title != nil || subtitle != nil {
                VStack(alignment: .leading, spacing: theme.space.x1) {
                    if let title {
                        Text(title)
                            .font(theme.typography.headline.font)
                            .foregroundStyle(theme.colors.foreground.color)
                    }

                    if let subtitle {
                        Text(subtitle)
                            .font(theme.typography.subheadline.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }
            }

            chartSurface

            footer
        }
        .padding(theme.space.x4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        .accessibilityElement(children: .contain)
    }

    @ViewBuilder
    private var chartSurface: some View {
        switch state {
        case .ready:
            chartContent
                .frame(height: height)
                .frame(maxWidth: .infinity)
        case .loading:
            CNChartLoadingState(height: height)
        case let .empty(title, message):
            CNChartEmptyState(title, message: message, systemImage: "chart.xyaxis.line", height: height)
        case let .error(title, message):
            CNChartEmptyState(title, message: message, systemImage: "exclamationmark.triangle", height: height)
        }
    }
}

public extension CNChartContainer where Footer == EmptyView {
    /// Creates a chart container without footer content.
    init(
        title: String? = nil,
        subtitle: String? = nil,
        state: CNChartState = .ready,
        height: CGFloat = 240,
        @ViewBuilder content: () -> ChartContent
    ) {
        self.init(title: title, subtitle: subtitle, state: state, height: height, content: content) {
            EmptyView()
        }
    }
}

/// A chart legend built from NativeCN chart series metadata.
public struct CNChartLegend: View {
    @Environment(\.cnTheme) private var theme

    private let items: [CNChartSeries]
    private let columns: Int

    /// Creates a chart legend.
    public init(_ items: [CNChartSeries], columns: Int = 2) {
        self.items = items
        self.columns = max(1, columns)
    }

    /// The chart legend body.
    public var body: some View {
        LazyVGrid(columns: gridColumns, alignment: .leading, spacing: theme.space.x2) {
            ForEach(items) { item in
                HStack(alignment: .top, spacing: theme.space.x2) {
                    Circle()
                        .fill(item.color(in: theme).color)
                        .frame(width: 8, height: 8)
                        .padding(.top, 5)
                        .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: theme.space.x1) {
                        Text(item.title)
                            .font(theme.typography.caption.font.weight(.medium))
                            .foregroundStyle(theme.colors.foreground.color)

                        if let detail = item.detail {
                            Text(detail)
                                .font(theme.typography.caption.font)
                                .foregroundStyle(theme.colors.mutedForeground.color)
                        }
                    }
                }
                .accessibilityElement(children: .combine)
            }
        }
    }

    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: theme.space.x3, alignment: .leading), count: columns)
    }
}

/// A chart loading placeholder.
public struct CNChartLoadingState: View {
    @Environment(\.cnTheme) private var theme

    private let height: CGFloat

    /// Creates a chart loading state.
    public init(height: CGFloat = 240) {
        self.height = max(120, height)
    }

    /// The loading state body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x3) {
            ForEach(0..<5, id: \.self) { index in
                CNSkeleton(height: CGFloat(18 + index * 8), shape: .roundedRectangle)
                    .frame(maxWidth: CGFloat(0.5 + Double(index) * 0.1) * 420)
            }
        }
        .padding(theme.space.x4)
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .bottomLeading)
        .background(theme.colors.muted.color.opacity(0.35))
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        .accessibilityLabel("Chart loading")
    }
}

/// A reusable empty or error state for chart containers.
public struct CNChartEmptyState: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let message: String?
    private let systemImage: String
    private let height: CGFloat

    /// Creates a chart empty state.
    public init(_ title: String, message: String? = nil, systemImage: String = "chart.xyaxis.line", height: CGFloat = 240) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
        self.height = max(120, height)
    }

    /// The empty state body.
    public var body: some View {
        VStack(spacing: theme.space.x3) {
            Image(systemName: systemImage)
                .font(.title2.weight(.semibold))
                .foregroundStyle(theme.colors.mutedForeground.color)
                .accessibilityHidden(true)

            VStack(spacing: theme.space.x1) {
                Text(title)
                    .font(theme.typography.headline.font)
                    .foregroundStyle(theme.colors.foreground.color)

                if let message {
                    Text(message)
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding(theme.space.x4)
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
        .background(theme.colors.muted.color.opacity(0.35))
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        .accessibilityElement(children: .combine)
    }
}
