import SwiftUI

struct CNToggle_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNTogglePreviewContent()
                .padding()
        }
    }
}

private struct CNTogglePreviewContent: View {
    @State private var enabled = true
    @State private var selection: Set<String> = ["bold"]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            CNToggle("Selected", isOn: $enabled)

            CNToggleGroup(
                selection: $selection,
                options: [
                    CNToggleGroupOption("Bold", value: "bold", systemImage: "bold"),
                    CNToggleGroupOption("Italic", value: "italic", systemImage: "italic"),
                    CNToggleGroupOption("Underline", value: "underline", systemImage: "underline"),
                ]
            )
        }
    }
}
