import SwiftUI

struct CNAvatar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                avatarPreviewContent
            }
            .previewDisplayName("Avatars Light")

            CNThemeProvider(.nativeCNDark) {
                avatarPreviewContent
            }
            .previewDisplayName("Avatars Dark")
            .preferredColorScheme(.dark)
        }
    }

    private static var avatarPreviewContent: some View {
        HStack(spacing: 16) {
            CNAvatar(fallback: "JD", size: .sm)
            CNAvatar(fallback: "AL", size: .md)
            CNAvatar(fallback: "Native", size: .lg)
            CNAvatar(size: .xl)
            CNAvatar(url: URL(string: "https://example.invalid/avatar.png"), fallback: "ER", size: .lg)
        }
        .padding()
    }
}
