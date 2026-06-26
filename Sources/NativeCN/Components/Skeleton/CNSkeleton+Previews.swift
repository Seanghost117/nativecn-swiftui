import SwiftUI

struct CNSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                skeletonPreviewContent
            }
            .previewDisplayName("Skeletons Light")

            CNThemeProvider(.nativeCNDark) {
                skeletonPreviewContent
            }
            .previewDisplayName("Skeletons Dark")
            .preferredColorScheme(.dark)
        }
    }

    private static var skeletonPreviewContent: some View {
        VStack(alignment: .leading, spacing: 14) {
            CNSkeleton(width: 180, height: 18)
            CNSkeleton(width: 260, height: 18)
            CNSkeleton(width: 120, height: 18, shape: .rectangle)
            HStack {
                CNSkeleton(shape: .circle, size: 48)
                VStack(alignment: .leading) {
                    CNSkeleton(width: 160, height: 16)
                    CNSkeleton(width: 220, height: 16)
                }
            }
        }
        .padding()
    }
}
