import SwiftUI

private struct CNFieldInvalidKey: EnvironmentKey {
    static let defaultValue = false
}

public extension EnvironmentValues {
    /// Whether the current NativeCN field subtree is invalid.
    var cnFieldIsInvalid: Bool {
        get { self[CNFieldInvalidKey.self] }
        set { self[CNFieldInvalidKey.self] = newValue }
    }
}
