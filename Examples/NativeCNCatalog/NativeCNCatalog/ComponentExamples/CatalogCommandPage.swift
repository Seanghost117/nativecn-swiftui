import NativeCN
import SwiftUI

struct CatalogCommandPage: View {
    @Environment(\.cnTheme) private var theme

    @State private var showingPalette = false
    @State private var selectedCommand = "No command selected"

    private let commands = [
        CNCommandItem(id: "new-project", title: "New Project", subtitle: "Create a workspace from a template", group: "Projects", systemImage: "plus", keywords: ["create", "workspace"]),
        CNCommandItem(id: "open-project", title: "Open Project", subtitle: "Browse recent projects", group: "Projects", systemImage: "folder", keywords: ["recent"]),
        CNCommandItem(id: "theme", title: "Toggle Theme", subtitle: "Switch between light and dark", group: "Settings", systemImage: "moon"),
        CNCommandItem(id: "billing", title: "Billing Settings", subtitle: "Manage plan and invoices", group: "Settings", systemImage: "creditcard"),
        CNCommandItem(id: "archive", title: "Archive Workspace", subtitle: "Unavailable for active workspaces", group: "Danger Zone", systemImage: "archivebox", isDisabled: true),
    ]

    var body: some View {
        CatalogPage(
            title: "Command",
            subtitle: "Searchable action palettes for keyboard-first workflows."
        ) {
            CNSection("Command Palette", subtitle: "Grouped commands with search and native sheet presentation.") {
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 10) {
                        CNButton("Open palette", variant: .outline) {
                            showingPalette = true
                        }

                        CNKeyboardShortcut("Command", "K")
                    }

                    CNNote(selectedCommand, title: "Selection")

                    CNCommandPalette(items: commands) { item in
                        selectedCommand = "Selected: \(item.title)"
                    }
                    .frame(minHeight: 420)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .cnBorder(color: theme.colors.border, cornerRadius: 8)
                }
                .padding(16)
            }
        }
        .cnCommandPalette(isPresented: $showingPalette, items: commands) { item in
            selectedCommand = "Selected: \(item.title)"
            showingPalette = false
        }
    }
}
