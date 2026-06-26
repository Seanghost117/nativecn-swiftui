import SwiftUI

/// A tab trigger item for `CNTabs`.
public struct CNTabItem<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Tab title.
    public var title: String

    /// Tab value.
    public var value: Value

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a tab item.
    public init(_ title: String, value: Value, systemImage: String? = nil) {
        self.title = title
        self.value = value
        self.systemImage = systemImage
    }
}

/// A token-driven tab trigger row.
public struct CNTabs<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var selection: Value
    private let items: [CNTabItem<Value>]
    private let isDisabled: Bool

    /// Creates a tab trigger row.
    public init(selection: Binding<Value>, items: [CNTabItem<Value>], isDisabled: Bool = false) {
        self._selection = selection
        self.items = items
        self.isDisabled = isDisabled
    }

    /// The tab body.
    public var body: some View {
        HStack(spacing: theme.space.x1) {
            ForEach(items) { item in
                Button {
                    selection = item.value
                } label: {
                    HStack(spacing: theme.space.x2) {
                        if let systemImage = item.systemImage {
                            Image(systemName: systemImage)
                                .accessibilityHidden(true)
                        }

                        Text(item.title)
                    }
                    .font(theme.typography.subheadline.font.weight(.medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                    .foregroundStyle(foreground(for: item).color)
                    .padding(.horizontal, theme.space.x3)
                    .frame(minHeight: 34)
                    .background(background(for: item).color)
                    .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
                    .contentShape(RoundedRectangle(cornerRadius: theme.radius.md))
                }
                .buttonStyle(.plain)
                .accessibilityValue(selection == item.value ? Text("Selected") : Text("Not selected"))
            }
        }
        .padding(theme.space.x1)
        .background(theme.colors.muted.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .contain)
    }

    private func foreground(for item: CNTabItem<Value>) -> CNColorToken {
        selection == item.value ? theme.colors.foreground : theme.colors.mutedForeground
    }

    private func background(for item: CNTabItem<Value>) -> CNColorToken {
        selection == item.value ? theme.colors.background : CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)
    }
}
