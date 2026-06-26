import SwiftUI

/// A styled sheet content container.
public struct CNSheet<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String?
    private let message: String?
    private let content: Content

    /// Creates a sheet content container.
    public init(title: String? = nil, message: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.message = message
        self.content = content()
    }

    /// The sheet body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x4) {
            if title != nil || message != nil {
                VStack(alignment: .leading, spacing: theme.space.x2) {
                    if let title {
                        Text(title)
                            .font(theme.typography.title3.font)
                            .foregroundStyle(theme.colors.foreground.color)
                            .accessibilityAddTraits(.isHeader)
                    }

                    if let message {
                        Text(message)
                            .font(theme.typography.body.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }
            }

            content
        }
        .padding(theme.space.x5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.background.color)
    }
}

public extension View {
    /// Presents a native SwiftUI sheet containing `CNSheet` content.
    func cnSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        title: String? = nil,
        message: String? = nil,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        sheet(isPresented: isPresented) {
            CNSheet(title: title, message: message) {
                content()
            }
            .presentationDetents([.medium, .large])
        }
    }
}
