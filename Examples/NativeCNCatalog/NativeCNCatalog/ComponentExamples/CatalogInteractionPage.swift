import NativeCN
import SwiftUI

struct CatalogInteractionPage: View {
    @State private var releaseExpanded = true
    @State private var advancedExpanded = false
    @State private var selectedAction = "No action selected"

    var body: some View {
        CatalogPage(
            title: "Interaction",
            subtitle: "Disclosure and contextual actions adapted to native SwiftUI."
        ) {
            CNSection("Accordion", subtitle: "Progressive disclosure for settings, docs, and status detail.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNAccordion("Release readiness", subtitle: "Build, review, and rollout state", systemImage: "shippingbox", isExpanded: $releaseExpanded) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                CNBadge("Ready", variant: .secondary)
                                Text("All required checks passed.")
                                    .font(.subheadline)
                            }

                            CNSeparator()

                            CNDescriptionList([
                                CNDescriptionItem(id: "build", label: "Build", value: "2026.06.25.1"),
                                CNDescriptionItem(id: "reviewer", label: "Reviewer", value: "Design Systems"),
                                CNDescriptionItem(id: "window", label: "Window", value: "Today"),
                            ])
                        }
                    }

                    CNAccordion("Rollback plan", subtitle: "Collapsed by default", systemImage: "arrow.uturn.backward") {
                        Text("Keep the previous registry bundle available until the rollout is complete.")
                            .font(.subheadline)
                    }
                }
                .padding(16)
            }

            CNSection("Collapsible", subtitle: "Compact disclosure for optional controls and details.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNCollapsible("Advanced options", subtitle: "Reveal less common setup choices", systemImage: "slider.horizontal.3", isExpanded: $advancedExpanded) {
                        VStack(alignment: .leading, spacing: 10) {
                            Toggle("Enable verbose logs", isOn: .constant(true))
                                .toggleStyle(.switch)

                            Toggle("Send release summary", isOn: .constant(false))
                                .toggleStyle(.switch)

                            Text("These controls stay out of the main flow until a user asks for them.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    CNCollapsible("Import notes", subtitle: "Collapsed by default", systemImage: "doc.text") {
                        Text("Keep optional instructions close to the action without making the whole page heavier.")
                            .font(.subheadline)
                    }
                }
                .padding(16)
            }

            CNSection("Context Menu", subtitle: "Native secondary actions for rows and cards.") {
                VStack(alignment: .leading, spacing: 12) {
                    Text(selectedAction)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    CNListRow("Project Alpha", subtitle: "Right-click or long-press this row", systemImage: "folder")
                        .cnContextMenu(items: [
                            CNContextMenuItem(id: "rename", title: "Rename", systemImage: "pencil"),
                            CNContextMenuItem(id: "duplicate", title: "Duplicate", systemImage: "doc.on.doc"),
                            CNContextMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                        ]) { item in
                            selectedAction = "Selected: \(item.title)"
                        }
                }
                .padding(16)
            }
        }
    }
}
