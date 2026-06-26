import SwiftUI

#if os(iOS)
import UIKit
#endif

/// Keyboard hints supported by NativeCN input on platforms where SwiftUI exposes keyboard type.
public enum CNInputKeyboardType: String, Sendable, Equatable {
    /// Default text keyboard.
    case `default`

    /// Email keyboard.
    case emailAddress

    /// Numeric keyboard.
    case numberPad

    /// Decimal keyboard.
    case decimalPad

    /// URL keyboard.
    case URL

    /// Phone keyboard.
    case phonePad
}

#if os(iOS)
private extension CNInputKeyboardType {
    var uiKeyboardType: UIKeyboardType {
        switch self {
        case .default:
            return .default
        case .emailAddress:
            return .emailAddress
        case .numberPad:
            return .numberPad
        case .decimalPad:
            return .decimalPad
        case .URL:
            return .URL
        case .phonePad:
            return .phonePad
        }
    }
}
#endif

/// A single-line token-driven text input.
public struct CNInput<Leading: View, Trailing: View>: View {
    @Environment(\.cnTheme) private var theme
    @Environment(\.cnFieldIsInvalid) private var fieldIsInvalid
    @FocusState private var isFocusedInternally: Bool

    private let placeholder: String
    @Binding private var text: String
    private let isDisabled: Bool
    private let isInvalid: Bool
    private let keyboardType: CNInputKeyboardType
    private let submitLabel: SubmitLabel
    private let focusBinding: FocusState<Bool>.Binding?
    private let leading: Leading
    private let trailing: Trailing

    /// Creates an input with custom leading and trailing content.
    public init(
        _ placeholder: String,
        text: Binding<String>,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        keyboardType: CNInputKeyboardType = .default,
        submitLabel: SubmitLabel = .done,
        focus: FocusState<Bool>.Binding? = nil,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.placeholder = placeholder
        self._text = text
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.keyboardType = keyboardType
        self.submitLabel = submitLabel
        self.focusBinding = focus
        self.leading = leading()
        self.trailing = trailing()
    }

    /// The input body.
    public var body: some View {
        let invalid = isInvalid || fieldIsInvalid
        let metrics = CNControlSize.md.metrics(in: theme)
        let borderColor = invalid ? theme.colors.destructive : theme.colors.input

        HStack(spacing: theme.space.x2) {
            leading
                .foregroundStyle(theme.colors.mutedForeground.color)

            configuredTextField
                .font(theme.typography.body.font)
                .foregroundStyle(theme.colors.foreground.color)
                .disabled(isDisabled)

            trailing
                .foregroundStyle(theme.colors.mutedForeground.color)
        }
        .padding(.horizontal, metrics.horizontalPadding)
        .frame(minHeight: metrics.height)
        .background(theme.colors.background.color)
        .clipShape(RoundedRectangle(cornerRadius: metrics.cornerRadius))
        .cnBorder(color: borderColor, lineWidth: invalid ? 1.5 : 1, cornerRadius: metrics.cornerRadius)
        .cnFocusRing(isFocused: isFocusedInternally, cornerRadius: metrics.cornerRadius)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .combine)
        .accessibilityHint(invalid ? "Invalid input" : "")
    }

    @ViewBuilder
    private var configuredTextField: some View {
        #if os(iOS)
        let field = TextField(placeholder, text: $text)
            .textFieldStyle(.plain)
            .keyboardType(keyboardType.uiKeyboardType)
            .submitLabel(submitLabel)
        #else
        let field = TextField(placeholder, text: $text)
            .textFieldStyle(.plain)
            .submitLabel(submitLabel)
        #endif

        if let focusBinding {
            field.focused(focusBinding)
        } else {
            field.focused($isFocusedInternally)
        }
    }
}

public extension CNInput where Leading == EmptyView, Trailing == EmptyView {
    /// Creates an input without accessory content.
    init(
        _ placeholder: String,
        text: Binding<String>,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        keyboardType: CNInputKeyboardType = .default,
        submitLabel: SubmitLabel = .done,
        focus: FocusState<Bool>.Binding? = nil
    ) {
        self.init(
            placeholder,
            text: text,
            isDisabled: isDisabled,
            isInvalid: isInvalid,
            keyboardType: keyboardType,
            submitLabel: submitLabel,
            focus: focus
        ) {
            EmptyView()
        } trailing: {
            EmptyView()
        }
    }
}

public extension CNInput where Leading == Image, Trailing == EmptyView {
    /// Creates an input with a leading SF Symbol.
    init(
        _ placeholder: String,
        text: Binding<String>,
        leadingIcon: String,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        keyboardType: CNInputKeyboardType = .default,
        submitLabel: SubmitLabel = .done,
        focus: FocusState<Bool>.Binding? = nil
    ) {
        self.init(
            placeholder,
            text: text,
            isDisabled: isDisabled,
            isInvalid: isInvalid,
            keyboardType: keyboardType,
            submitLabel: submitLabel,
            focus: focus
        ) {
            Image(systemName: leadingIcon)
        } trailing: {
            EmptyView()
        }
    }
}

public extension CNInput where Leading == EmptyView {
    /// Creates an input with trailing accessory content.
    init(
        _ placeholder: String,
        text: Binding<String>,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        keyboardType: CNInputKeyboardType = .default,
        submitLabel: SubmitLabel = .done,
        focus: FocusState<Bool>.Binding? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.init(
            placeholder,
            text: text,
            isDisabled: isDisabled,
            isInvalid: isInvalid,
            keyboardType: keyboardType,
            submitLabel: submitLabel,
            focus: focus
        ) {
            EmptyView()
        } trailing: {
            trailing()
        }
    }
}

public extension CNInput where Trailing == EmptyView {
    /// Creates an input with leading accessory content.
    init(
        _ placeholder: String,
        text: Binding<String>,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        keyboardType: CNInputKeyboardType = .default,
        submitLabel: SubmitLabel = .done,
        focus: FocusState<Bool>.Binding? = nil,
        @ViewBuilder leading: () -> Leading
    ) {
        self.init(
            placeholder,
            text: text,
            isDisabled: isDisabled,
            isInvalid: isInvalid,
            keyboardType: keyboardType,
            submitLabel: submitLabel,
            focus: focus
        ) {
            leading()
        } trailing: {
            EmptyView()
        }
    }
}
