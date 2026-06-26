import SwiftUI

struct CNHoverCard_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNButton("Project details", variant: .outline) {}
                .cnHoverCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("NativeCN")
                            .font(.headline)
                        Text("SwiftUI component primitives with registry-backed source ownership.")
                    }
                }
                .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
