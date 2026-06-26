import SwiftUI

struct CNCommand_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNCommandPalette(items: [
                CNCommandItem(id: "new", title: "New Project", subtitle: "Create a workspace", group: "Projects", systemImage: "plus"),
                CNCommandItem(id: "open", title: "Open Project", subtitle: "Browse recent files", group: "Projects", systemImage: "folder"),
                CNCommandItem(id: "theme", title: "Toggle Theme", subtitle: "Switch light and dark mode", group: "Settings", systemImage: "moon"),
            ]) { _ in }
        }
        .previewLayout(.sizeThatFits)
    }
}
