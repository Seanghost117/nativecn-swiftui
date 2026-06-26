import SwiftUI

struct CNThemeProvider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                CNThemePreviewSample()
            }
            .previewDisplayName("NativeCN Light")
            .preferredColorScheme(.light)

            CNThemeProvider(.nativeCNDark) {
                CNThemePreviewSample()
            }
            .previewDisplayName("NativeCN Dark")
            .preferredColorScheme(.dark)
        }
    }
}

private struct CNThemePreviewSample: View {
    @Environment(\.cnTheme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x3) {
            Text("NativeCN")
                .font(theme.typography.headline.font)
                .foregroundStyle(theme.colors.foreground.color)

            Text("Default themes read from the SwiftUI environment.")
                .font(theme.typography.body.font)
                .foregroundStyle(theme.colors.mutedForeground.color)
        }
        .padding(theme.space.x4)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .padding(theme.space.x4)
        .background(theme.colors.background.color)
    }
}
