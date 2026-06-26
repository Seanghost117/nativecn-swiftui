import SwiftUI

struct CNDrawer_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNDrawer(title: "Inspector", message: "Review component details.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNBadge("Stable", variant: .secondary)
                    Text("Drawer content")
                        .font(.headline)
                }
            }
            .frame(width: 320, height: 420)
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
