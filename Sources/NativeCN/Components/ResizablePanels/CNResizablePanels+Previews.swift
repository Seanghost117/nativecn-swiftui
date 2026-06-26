import SwiftUI

struct CNResizablePanels_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNResizablePanels(initialFraction: 0.38) {
                panel("Sidebar", systemImage: "sidebar.left")
            } secondary: {
                panel("Detail", systemImage: "rectangle.and.text.magnifyingglass")
            }
            .frame(width: 420, height: 220)
            .cnBorder(cornerRadius: 12)
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }

    private static func panel(_ title: String, systemImage: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.title2)
            Text(title)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.secondary)
    }
}
