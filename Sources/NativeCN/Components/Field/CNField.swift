import SwiftUI

/// A reusable form field layout for labels, descriptions, errors, and controls.
public struct CNField<Control: View>: View {
    /// Field layout mode.
    public enum Layout: String, Sendable, Equatable {
        /// Vertical field layout.
        case vertical

        /// Compact horizontal label/control layout.
        case compact
    }

    @Environment(\.cnTheme) private var theme

    private let label: String?
    private let description: String?
    private let error: String?
    private let isRequired: Bool
    private let layout: Layout
    private let control: Control

    /// Creates a field.
    public init(
        label: String? = nil,
        description: String? = nil,
        error: String? = nil,
        isRequired: Bool = false,
        layout: Layout = .vertical,
        @ViewBuilder control: () -> Control
    ) {
        self.label = label
        self.description = description
        self.error = error
        self.isRequired = isRequired
        self.layout = layout
        self.control = control()
    }

    /// The field body.
    public var body: some View {
        Group {
            switch layout {
            case .vertical:
                verticalBody
            case .compact:
                compactBody
            }
        }
        .environment(\.cnFieldIsInvalid, error != nil)
        .accessibilityElement(children: .contain)
    }

    private var verticalBody: some View {
        VStack(alignment: .leading, spacing: theme.space.x2) {
            labelAndDescription

            control

            errorView
        }
    }

    private var compactBody: some View {
        VStack(alignment: .leading, spacing: theme.space.x2) {
            HStack(alignment: .firstTextBaseline, spacing: theme.space.x4) {
                if let label {
                    CNLabel(label, isRequired: isRequired)
                        .frame(maxWidth: 140, alignment: .leading)
                }

                control
            }

            if label == nil {
                descriptionView
            } else {
                descriptionView
                    .padding(.leading, 140 + theme.space.x4)
            }

            errorView
        }
    }

    @ViewBuilder
    private var labelAndDescription: some View {
        if label != nil || description != nil {
            VStack(alignment: .leading, spacing: theme.space.x1) {
                if let label {
                    CNLabel(label, isRequired: isRequired)
                }

                descriptionView
            }
        }
    }

    @ViewBuilder
    private var descriptionView: some View {
        if let description {
            Text(description)
                .font(theme.typography.footnote.font)
                .foregroundStyle(theme.colors.mutedForeground.color)
        }
    }

    @ViewBuilder
    private var errorView: some View {
        if let error {
            Text(error)
                .font(theme.typography.footnote.font)
                .foregroundStyle(theme.colors.destructive.color)
                .accessibilityLabel("Error: \(error)")
        }
    }
}
