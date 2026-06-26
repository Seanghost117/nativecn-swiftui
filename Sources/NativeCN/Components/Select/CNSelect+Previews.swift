import SwiftUI

struct CNSelect_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNSelectPreviewContent()
                .padding()
        }
    }
}

private struct CNSelectPreviewContent: View {
    @State private var role: String? = "admin"

    var body: some View {
        CNSelect(
            "Role",
            selection: $role,
            options: [
                CNSelectOption("Admin", value: "admin"),
                CNSelectOption("Editor", value: "editor"),
                CNSelectOption("Viewer", value: "viewer"),
            ]
        )
    }
}
