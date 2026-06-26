import SwiftUI

struct CNTextarea_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                CNTextareaPreviewContent()
            }
            .previewDisplayName("Textarea Light")

            CNThemeProvider(.nativeCNDark) {
                CNTextareaPreviewContent()
            }
            .previewDisplayName("Textarea Dark")
            .preferredColorScheme(.dark)
        }
    }
}

private struct CNTextareaPreviewContent: View {
    @State private var message = ""
    @State private var notes = "Native multiline editing."

    var body: some View {
        VStack(spacing: 18) {
            CNField(label: "Message", description: "Placeholder and minimum height") {
                CNTextarea("Write your message", text: $message)
            }

            CNField(label: "Notes", error: "Please add more detail.") {
                CNTextarea("Notes", text: $notes, minHeight: 100, maxHeight: 160)
            }
        }
        .padding()
    }
}
