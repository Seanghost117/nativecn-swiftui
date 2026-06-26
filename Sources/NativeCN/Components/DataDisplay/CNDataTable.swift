import SwiftUI

/// A column definition for `CNDataTable`.
public struct CNDataTableColumn: Identifiable, Sendable, Equatable {
    /// Column alignment.
    public enum Alignment: String, Sendable, Equatable {
        /// Leading alignment.
        case leading

        /// Center alignment.
        case center

        /// Trailing alignment.
        case trailing
    }

    /// Column identifier.
    public var id: String

    /// Column title.
    public var title: String

    /// Minimum column width.
    public var minWidth: CGFloat

    /// Column alignment.
    public var alignment: Alignment

    /// Creates a data table column.
    public init(id: String, title: String, minWidth: CGFloat = 120, alignment: Alignment = .leading) {
        self.id = id
        self.title = title
        self.minWidth = minWidth
        self.alignment = alignment
    }
}

/// A row for `CNDataTable`.
public struct CNDataTableRow: Identifiable, Sendable, Equatable {
    /// Row identifier.
    public var id: String

    /// Cell values keyed by column identifier.
    public var values: [String: String]

    /// Creates a data table row.
    public init(id: String, values: [String: String]) {
        self.id = id
        self.values = values
    }
}

/// A lightweight, horizontally scrollable data table.
public struct CNDataTable: View {
    @Environment(\.cnTheme) private var theme

    private let columns: [CNDataTableColumn]
    private let rows: [CNDataTableRow]
    private let onSelect: (CNDataTableRow) -> Void

    /// Creates a data table.
    public init(columns: [CNDataTableColumn], rows: [CNDataTableRow], onSelect: @escaping (CNDataTableRow) -> Void = { _ in }) {
        self.columns = columns
        self.rows = rows
        self.onSelect = onSelect
    }

    /// The data table body.
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            VStack(spacing: 0) {
                header

                CNSeparator()

                ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                    Button {
                        onSelect(row)
                    } label: {
                        HStack(spacing: 0) {
                            ForEach(columns) { column in
                                Text(row.values[column.id] ?? "")
                                    .font(theme.typography.subheadline.font)
                                    .foregroundStyle(theme.colors.foreground.color)
                                    .lineLimit(2)
                                    .multilineTextAlignment(column.textAlignment)
                                    .frame(width: column.minWidth, alignment: column.frameAlignment)
                                    .padding(.horizontal, theme.space.x3)
                                    .padding(.vertical, theme.space.x3)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityElement(children: .combine)

                    if index < rows.count - 1 {
                        CNSeparator()
                    }
                }
            }
            .background(theme.colors.card.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
            .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        }
    }

    private var header: some View {
        HStack(spacing: 0) {
            ForEach(columns) { column in
                Text(column.title)
                    .font(theme.typography.caption.font.weight(.semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .textCase(.uppercase)
                    .lineLimit(1)
                    .frame(width: column.minWidth, alignment: column.frameAlignment)
                    .padding(.horizontal, theme.space.x3)
                    .padding(.vertical, theme.space.x2)
            }
        }
        .background(theme.colors.muted.color)
        .accessibilityElement(children: .combine)
    }
}

private extension CNDataTableColumn {
    var frameAlignment: SwiftUI.Alignment {
        switch alignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }

    var textAlignment: TextAlignment {
        switch alignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}
