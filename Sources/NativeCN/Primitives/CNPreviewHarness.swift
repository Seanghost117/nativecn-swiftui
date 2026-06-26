import SwiftUI

/// A named preview state used by component preview matrices.
public struct CNPreviewState: Identifiable, Sendable, Equatable {
    /// Stable preview identifier.
    public var id: String { name }

    /// Display name for the preview state.
    public var name: String

    /// Control state represented by this preview state.
    public var controlState: CNControlState

    /// Creates a preview state.
    public init(name: String, controlState: CNControlState = .enabled) {
        self.name = name
        self.controlState = controlState
    }
}

public extension CNPreviewState {
    /// Common state matrix for interactive controls.
    static let interactiveStates = [
        CNPreviewState(name: "Default"),
        CNPreviewState(name: "Pressed", controlState: CNControlState(isPressed: true)),
        CNPreviewState(name: "Focused", controlState: CNControlState(isFocused: true)),
        CNPreviewState(name: "Hovered", controlState: CNControlState(isHovered: true)),
        CNPreviewState(name: "Loading", controlState: .loading),
        CNPreviewState(name: "Disabled", controlState: .disabled),
        CNPreviewState(name: "Invalid", controlState: .invalid),
    ]
}

/// A lightweight SwiftUI preview grid for NativeCN component state matrices.
public struct CNPreviewMatrix<Content: View>: View {
    private let title: String
    private let states: [CNPreviewState]
    private let columns: [GridItem]
    private let content: (CNPreviewState) -> Content

    /// Creates a preview matrix.
    public init(
        _ title: String,
        states: [CNPreviewState] = CNPreviewState.interactiveStates,
        minColumnWidth: CGFloat = 160,
        @ViewBuilder content: @escaping (CNPreviewState) -> Content
    ) {
        self.title = title
        self.states = states
        self.columns = [
            GridItem(.adaptive(minimum: minColumnWidth), spacing: 16, alignment: .top),
        ]
        self.content = content
    }

    /// The matrix body.
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)

            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(states) { state in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(state.name)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        content(state)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
}
