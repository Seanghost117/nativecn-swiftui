import SwiftUI
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

/// A monospaced code block for commands and snippets.
public struct CNCodeBlock: View {
    @Environment(\.cnTheme) private var theme

    @State private var copied = false

    private let code: String
    private let language: String?
    private let title: String?
    private let isCopyable: Bool
    private let wrapsLines: Bool

    /// Creates a code block.
    public init(_ code: String, language: String? = nil, title: String? = nil, isCopyable: Bool = true, wrapsLines: Bool = false) {
        self.code = code
        self.language = language
        self.title = title
        self.isCopyable = isCopyable
        self.wrapsLines = wrapsLines
    }

    /// The code block body.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header

            CNSeparator()

            if wrapsLines {
                codeText
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(theme.space.x4)
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    codeText
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(theme.space.x4)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        .accessibilityElement(children: .combine)
    }

    private var header: some View {
        HStack(spacing: theme.space.x3) {
            HStack(spacing: theme.space.x2) {
                Image(systemName: "chevron.left.forwardslash.chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .accessibilityHidden(true)

                headerLabel
            }

            Spacer(minLength: theme.space.x3)

            if isCopyable {
                Button {
                    CNClipboard.copy(code)
                    copied = true
                    resetCopiedState()
                } label: {
                    HStack(spacing: theme.space.x1) {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                            .font(.caption.weight(.semibold))
                        Text(copied ? "Copied" : "Copy")
                            .font(theme.typography.caption.font.weight(.medium))
                    }
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .frame(height: 28)
                    .padding(.horizontal, theme.space.x2)
                    .background(theme.colors.card.color)
                    .clipShape(RoundedRectangle(cornerRadius: theme.radius.sm))
                    .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.sm)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(copied ? "Copied code" : "Copy code")
            }
        }
        .padding(.horizontal, theme.space.x4)
        .padding(.vertical, theme.space.x2)
        .background(theme.colors.muted.color)
    }

    private var headerLabel: some View {
        Group {
            if let title {
                Text(title)
            } else if let language {
                Text(language.uppercased())
            } else {
                Text("Code")
            }
        }
        .font(theme.typography.caption.font.weight(.medium))
        .foregroundStyle(theme.colors.mutedForeground.color)
    }

    private var codeText: some View {
        Text(verbatim: code)
            .font(theme.typography.mono.font)
            .foregroundStyle(theme.colors.foreground.color)
            .textSelection(.enabled)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }

    private func resetCopiedState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            copied = false
        }
    }
}

private enum CNClipboard {
    static func copy(_ text: String) {
        #if os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
        #elseif os(iOS)
        UIPasteboard.general.string = text
        #endif
    }
}
