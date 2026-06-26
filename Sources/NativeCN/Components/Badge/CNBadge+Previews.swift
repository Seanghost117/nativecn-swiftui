import SwiftUI

struct CNBadge_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                badgePreviewContent
            }
            .previewDisplayName("Badges Light")

            CNThemeProvider(.nativeCNDark) {
                badgePreviewContent
            }
            .previewDisplayName("Badges Dark")
            .preferredColorScheme(.dark)
        }
    }

    private static var badgePreviewContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                ForEach(CNBadge<Text>.Variant.allCases, id: \.self) { variant in
                    CNBadge(variant.rawValue.capitalized, variant: variant)
                }
            }

            CNBadge(variant: .outline) {
                Label("Synced", systemImage: "checkmark.circle")
            }
        }
        .padding()
    }
}
