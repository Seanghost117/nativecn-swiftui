import SwiftUI

struct CNTypography_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(alignment: .leading, spacing: 8) {
                CNTypography("NativeCN", style: .title)
                CNTypography("Composable SwiftUI components", style: .heading)
                CNTypography("Use semantic typography for content hierarchy.", style: .body)
                CNTypography("Muted text supports compact metadata.", style: .muted)
                CNTypography("Caption", style: .caption)
            }
            .padding()
        }
    }
}

