import SwiftUI

/// A compact disclosure surface for optional or advanced content.
public struct CNCollapsible<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    @State private var internalExpanded: Bool

    private let title: String
    private let subtitle: String?
    private let systemImage: String?
    private let externalExpanded: Binding<Bool>?
    private let content: Content

    /// Creates a collapsible section with internal expansion state.
    public init(
        _ title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        initiallyExpanded: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.externalExpanded = nil
        self.content = content()
        self._internalExpanded = State(initialValue: initiallyExpanded)
    }

    /// Creates a collapsible section with caller-owned expansion state.
    public init(
        _ title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        isExpanded: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.externalExpanded = isExpanded
        self.content = content()
        self._internalExpanded = State(initialValue: isExpanded.wrappedValue)
    }

    /// The collapsible body.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                toggleExpanded()
            } label: {
                HStack(spacing: theme.space.x3) {
                    if let systemImage {
                        Image(systemName: systemImage)
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(theme.colors.mutedForeground.color)
                            .frame(width: 18)
                            .accessibilityHidden(true)
                    }

                    VStack(alignment: .leading, spacing: theme.space.x1) {
                        Text(title)
                            .font(theme.typography.subheadline.font.weight(.medium))
                            .foregroundStyle(theme.colors.foreground.color)

                        if let subtitle {
                            Text(subtitle)
                                .font(theme.typography.caption.font)
                                .foregroundStyle(theme.colors.mutedForeground.color)
                        }
                    }

                    Spacer(minLength: theme.space.x3)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .rotationEffect(.degrees(currentExpanded ? 90 : 0))
                        .accessibilityHidden(true)
                }
                .padding(.horizontal, theme.space.x3)
                .padding(.vertical, theme.space.x3)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(title)
            .accessibilityValue(currentExpanded ? "Expanded" : "Collapsed")

            if currentExpanded {
                CNSeparator()

                content
                    .padding(theme.space.x3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.md)
    }

    private var currentExpanded: Bool {
        externalExpanded?.wrappedValue ?? internalExpanded
    }

    private func toggleExpanded() {
        if let externalExpanded {
            externalExpanded.wrappedValue.toggle()
        } else {
            internalExpanded.toggle()
        }
    }
}
