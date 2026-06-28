import SwiftUI

/// A static table column.
public struct CNTableColumn: Identifiable, Sendable, Equatable {
    /// Column identifier.
    public var id: String

    /// Column title.
    public var title: String

    /// Minimum column width.
    public var minWidth: CGFloat

    /// Column alignment.
    public var alignment: CNDataTableColumn.Alignment

    /// Creates a table column.
    public init(id: String, title: String, minWidth: CGFloat = 120, alignment: CNDataTableColumn.Alignment = .leading) {
        self.id = id
        self.title = title
        self.minWidth = minWidth
        self.alignment = alignment
    }
}

/// A static table row.
public struct CNTableRow: Identifiable, Sendable, Equatable {
    /// Row identifier.
    public var id: String

    /// Cell values keyed by column identifier.
    public var values: [String: String]

    /// Creates a table row.
    public init(id: String, values: [String: String]) {
        self.id = id
        self.values = values
    }
}

/// A non-interactive table for compact text datasets.
public struct CNTable: View {
    private let columns: [CNTableColumn]
    private let rows: [CNTableRow]

    /// Creates a table.
    public init(columns: [CNTableColumn], rows: [CNTableRow]) {
        self.columns = columns
        self.rows = rows
    }

    /// The table body.
    public var body: some View {
        CNDataTable(
            columns: columns.map { CNDataTableColumn(id: $0.id, title: $0.title, minWidth: $0.minWidth, alignment: $0.alignment) },
            rows: rows.map { CNDataTableRow(id: $0.id, values: $0.values) }
        )
    }
}

