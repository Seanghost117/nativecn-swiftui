import SwiftUI

struct CNMenubar_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNMenubar(menus: [
                CNMenubarMenu(id: "file", title: "File", items: [
                    CNMenubarItem(id: "new", title: "New", systemImage: "plus", shortcut: "Command N"),
                    CNMenubarItem(id: "open", title: "Open", systemImage: "folder", shortcut: "Command O"),
                ]),
                CNMenubarMenu(id: "edit", title: "Edit", items: [
                    CNMenubarItem(id: "duplicate", title: "Duplicate", systemImage: "doc.on.doc"),
                    CNMenubarItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                ]),
            ]) { _ in }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
