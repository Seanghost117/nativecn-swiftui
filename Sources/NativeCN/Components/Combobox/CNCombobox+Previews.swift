import SwiftUI

struct CNCombobox_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNComboboxPreviewContent()
                .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

private struct CNComboboxPreviewContent: View {
    @State private var selection: String? = "editor"

    var body: some View {
        CNCombobox("Role", selection: $selection, options: [
            CNComboboxOption("Admin", value: "admin", subtitle: "Full access", systemImage: "person.badge.key"),
            CNComboboxOption("Editor", value: "editor", subtitle: "Can publish changes", systemImage: "pencil"),
            CNComboboxOption("Viewer", value: "viewer", subtitle: "Read-only access", systemImage: "eye"),
        ])
        .frame(width: 280)
    }
}
