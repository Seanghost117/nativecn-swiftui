import SwiftUI

struct CNNativeSelect_Previews: PreviewProvider {
    struct Preview: View {
        @State private var role = "editor"

        var body: some View {
            CNThemeProvider {
                CNNativeSelect(
                    "Role",
                    selection: $role,
                    options: [
                        CNSelectOption("Admin", value: "admin"),
                        CNSelectOption("Editor", value: "editor"),
                        CNSelectOption("Viewer", value: "viewer"),
                    ]
                )
                .padding()
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}

