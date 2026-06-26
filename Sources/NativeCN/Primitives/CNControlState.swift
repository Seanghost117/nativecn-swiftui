/// Shared interaction state for NativeCN controls.
public struct CNControlState: Sendable, Equatable {
    /// Whether the control accepts user interaction.
    public var isEnabled: Bool

    /// Whether the control is currently pressed.
    public var isPressed: Bool

    /// Whether the control currently has keyboard or accessibility focus.
    public var isFocused: Bool

    /// Whether the control is currently hovered by a pointer.
    public var isHovered: Bool

    /// Whether the control is displaying loading/progress state.
    public var isLoading: Bool

    /// Whether the control is displaying validation failure state.
    public var isInvalid: Bool

    /// Creates a control state value.
    public init(
        isEnabled: Bool = true,
        isPressed: Bool = false,
        isFocused: Bool = false,
        isHovered: Bool = false,
        isLoading: Bool = false,
        isInvalid: Bool = false
    ) {
        self.isEnabled = isEnabled
        self.isPressed = isPressed
        self.isFocused = isFocused
        self.isHovered = isHovered
        self.isLoading = isLoading
        self.isInvalid = isInvalid
    }

    /// Whether the control should be treated as interactable.
    public var isInteractive: Bool {
        isEnabled && !isLoading
    }
}

public extension CNControlState {
    /// Default enabled control state.
    static let enabled = Self()

    /// Disabled control state.
    static let disabled = Self(isEnabled: false)

    /// Loading control state.
    static let loading = Self(isLoading: true)

    /// Invalid control state.
    static let invalid = Self(isInvalid: true)
}
