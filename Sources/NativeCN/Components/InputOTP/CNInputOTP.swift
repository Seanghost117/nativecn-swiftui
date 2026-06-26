import SwiftUI

#if os(iOS)
import UIKit
#endif

/// A slot-based one-time-code input for authentication flows.
public struct CNInputOTP: View {
    @Environment(\.cnTheme) private var theme
    @Environment(\.cnFieldIsInvalid) private var fieldIsInvalid
    @FocusState private var isFocused: Bool

    @Binding private var text: String

    private let length: Int
    private let groupSize: Int?
    private let label: String
    private let isDisabled: Bool
    private let isInvalid: Bool

    /// Creates a one-time-code input.
    public init(
        text: Binding<String>,
        length: Int = 6,
        groupSize: Int? = 3,
        label: String = "One-time code",
        isDisabled: Bool = false,
        isInvalid: Bool = false
    ) {
        self._text = text
        self.length = Self.normalizedLength(length)
        self.groupSize = Self.normalizedGroupSize(groupSize, length: Self.normalizedLength(length))
        self.label = label
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
    }

    /// The input body.
    public var body: some View {
        let invalid = isInvalid || fieldIsInvalid

        ZStack {
            configuredTextField
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityHidden(true)

            HStack(spacing: theme.space.x2) {
                ForEach(0..<length, id: \.self) { index in
                    if shouldInsertSeparator(before: index) {
                        Text("-")
                            .font(theme.typography.body.font.weight(.semibold))
                            .foregroundStyle(theme.colors.mutedForeground.color)
                            .accessibilityHidden(true)
                    }

                    slot(at: index, isInvalid: invalid)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard !isDisabled else {
                return
            }

            isFocused = true
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
        .accessibilityValue(accessibilityValue)
        .accessibilityHint(invalid ? "Invalid input" : "Enter the code")
    }

    /// Returns a digit-only string constrained to the requested slot count.
    public static func sanitized(_ text: String, length: Int) -> String {
        let maxLength = normalizedLength(length)
        let digits = text.filter(\.isWholeNumber)

        return String(digits.prefix(maxLength))
    }

    /// Returns a layout-safe OTP length.
    public static func normalizedLength(_ length: Int) -> Int {
        min(max(length, 1), 12)
    }

    /// Returns a layout-safe group size.
    public static func normalizedGroupSize(_ groupSize: Int?, length: Int) -> Int? {
        guard let groupSize, groupSize > 0, groupSize < normalizedLength(length) else {
            return nil
        }

        return groupSize
    }

    @ViewBuilder
    private var configuredTextField: some View {
        #if os(iOS)
        TextField("", text: sanitizedBinding)
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .focused($isFocused)
        #else
        TextField("", text: sanitizedBinding)
            .focused($isFocused)
        #endif
    }

    private var sanitizedBinding: Binding<String> {
        Binding {
            text
        } set: { newValue in
            text = Self.sanitized(newValue, length: length)
        }
    }

    private func slot(at index: Int, isInvalid: Bool) -> some View {
        let character = character(at: index)
        let isActive = isFocused && index == activeIndex
        let borderColor = isInvalid ? theme.colors.destructive : (isActive ? theme.colors.ring : theme.colors.input)

        return Text(character ?? "")
            .font(.system(.title3, design: .monospaced).weight(.semibold))
            .foregroundStyle(theme.colors.foreground.color)
            .frame(width: 42, height: 48)
            .background(theme.colors.background.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
            .cnBorder(color: borderColor, lineWidth: isInvalid || isActive ? 1.5 : 1, cornerRadius: theme.radius.md)
            .cnFocusRing(isFocused: isActive, cornerRadius: theme.radius.md)
    }

    private func character(at index: Int) -> String? {
        let characters = Array(text)

        guard characters.indices.contains(index) else {
            return nil
        }

        return String(characters[index])
    }

    private var activeIndex: Int {
        min(text.count, length - 1)
    }

    private var accessibilityValue: String {
        text.isEmpty ? "No code entered" : "\(text.count) of \(length) digits entered"
    }

    private func shouldInsertSeparator(before index: Int) -> Bool {
        guard let groupSize else {
            return false
        }

        return index > 0 && index % groupSize == 0
    }
}
