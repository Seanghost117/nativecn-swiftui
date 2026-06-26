import SwiftUI

struct CNInteraction_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(alignment: .leading, spacing: 16) {
                CNAccordion("Deployment details", subtitle: "Build, checks, and release notes", systemImage: "shippingbox", initiallyExpanded: true) {
                    VStack(alignment: .leading, spacing: 8) {
                        CNBadge("Ready", variant: .secondary)
                        Text("All required checks passed and the release can be promoted.")
                    }
                }

                CNCollapsible("Advanced options", subtitle: "Reveal optional release controls", systemImage: "slider.horizontal.3", initiallyExpanded: true) {
                    VStack(alignment: .leading, spacing: 8) {
                        Toggle("Enable verbose logs", isOn: .constant(true))
                        Toggle("Send release summary", isOn: .constant(false))
                    }
                    .font(.subheadline)
                }

                CNListRow("Project Alpha", subtitle: "Right-click or long-press for actions", systemImage: "folder")
                    .cnContextMenu(items: [
                        CNContextMenuItem(id: "rename", title: "Rename", systemImage: "pencil"),
                        CNContextMenuItem(id: "archive", title: "Archive", systemImage: "archivebox"),
                        CNContextMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                    ]) { _ in }
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
