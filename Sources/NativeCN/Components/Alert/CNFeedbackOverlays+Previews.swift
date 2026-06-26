import SwiftUI

struct CNFeedbackOverlays_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNFeedbackOverlayPreviewContent()
                .padding()
        }
    }
}

private struct CNFeedbackOverlayPreviewContent: View {
    @State private var dialogPresented = true
    @State private var sheetPresented = false
    @State private var toast: CNToast? = CNToast(title: "Saved", message: "Your changes were saved.", variant: .success)
    @State private var popoverPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            CNAlert("Update available", message: "A new component release is ready.", variant: .default)
            CNAlert("Payment failed", message: "Update billing details to continue.", variant: .destructive) {
                CNButton("Review", variant: .outline, size: .sm) {}
            }

            HStack {
                CNButton("Sheet", variant: .outline) {
                    sheetPresented = true
                }

                CNButton("Popover", variant: .outline) {
                    popoverPresented = true
                }
                .cnPopover(isPresented: $popoverPresented) {
                    Text("Popover content")
                }

                CNButton("Tooltip", variant: .outline) {}
                    .cnTooltip("Short contextual help.")

                CNDropdownMenu("Actions", items: [
                    CNDropdownMenuItem(id: "edit", title: "Edit", systemImage: "pencil"),
                    CNDropdownMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                ]) { _ in }
            }
        }
        .cnToast($toast)
        .cnDialog(isPresented: $dialogPresented) {
            CNDialog(title: "Discard changes?", message: "This action cannot be undone.") {
                CNButton("Cancel", variant: .outline) {
                    dialogPresented = false
                }
                CNButton("Discard", variant: .destructive) {
                    dialogPresented = false
                }
            }
        }
        .cnSheet(isPresented: $sheetPresented, title: "Sheet", message: "Native sheet presentation with NativeCN content.") {
            CNButton("Done") {
                sheetPresented = false
            }
        }
    }
}
