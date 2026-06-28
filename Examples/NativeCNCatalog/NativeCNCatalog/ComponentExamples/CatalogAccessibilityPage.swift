import NativeCN
import SwiftUI

struct CatalogAccessibilityPage: View {
    @Environment(\.cnTheme) private var theme

    @State private var voiceOverChecked = true
    @State private var keyboardChecked = false
    @State private var dynamicTypeChecked = false
    @State private var reduceMotionChecked = true
    @State private var errorText = ""
    @State private var selectedPriority = "required"
    @State private var focusSummary = "No control focused"
    @State private var toast: CNToast?

    var body: some View {
        CatalogPage(
            title: "Accessibility QA",
            subtitle: "Manual review surfaces for VoiceOver, Keyboard navigation, Dynamic Type, Reduce Motion, labels, and error copy."
        ) {
            CNPageHeader("Accessibility QA", subtitle: "Use this page as the first manual assistive technology pass before reviewing each component page.") {
                CNButton("Announce", variant: .outline, size: .sm) {
                    toast = CNToast(title: "Accessibility QA", message: "Manual checklist updated.", variant: .success)
                }
            }

            checklistSection
            semanticsSection
            keyboardSection
            dynamicTypeSection
            reducedMotionSection
            matrixSection
        }
        .cnToast($toast)
    }

    private var checklistSection: some View {
        CNSection("Manual Checklist", subtitle: "Track the core QA areas while moving through the catalog.") {
            VStack(alignment: .leading, spacing: 14) {
                CNCheckbox("VoiceOver reads headings, labels, values, and row state in a useful order.", isOn: $voiceOverChecked)
                CNCheckbox("Keyboard focus can reach actions, fields, menus, and overlays.", isOn: $keyboardChecked)
                CNCheckbox("Dynamic Type keeps content readable without clipped controls.", isOn: $dynamicTypeChecked)
                CNCheckbox("Reduce Motion suppresses shimmer and decorative movement.", isOn: $reduceMotionChecked)

                CNProgress(value: checklistProgress, label: "Accessibility QA checklist progress")
            }
            .padding(16)
        }
    }

    private var semanticsSection: some View {
        CNSection("Labels & Errors", subtitle: "Confirm readable accessibilityLabel values and field error copy.") {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 10) {
                    CNButton(variant: .outline, size: .sm) {
                        toast = CNToast(title: "Icon button", message: "The button exposes an accessibilityLabel.")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .accessibilityHidden(true)
                    }
                    .accessibilityLabel("Share accessibility QA notes")

                    CNButton(variant: .ghost, size: .sm) {
                        toast = CNToast(title: "Favorite", message: "Icon-only controls need explicit labels.")
                    } label: {
                        Image(systemName: "star")
                            .accessibilityHidden(true)
                    }
                    .accessibilityLabel("Favorite accessibility QA page")

                    Text("Icon-only controls should never rely on the SF Symbol name.")
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }

                CNField(
                    label: "Release note",
                    description: "Leave this empty to hear the error state.",
                    error: errorText.isEmpty ? "Release note is required for QA sign-off." : nil
                ) {
                    CNInput("Summarize the accessibility pass", text: $errorText)
                }

                CNCallout("Readable copy", message: "Errors and statuses should be understandable when read aloud without relying on color.", variant: .warning)
            }
            .padding(16)
        }
    }

    private var keyboardSection: some View {
        CNSection("Keyboard", subtitle: "Exercise focus order, selectable rows, and native menu-backed controls.") {
            VStack(alignment: .leading, spacing: 16) {
                CNListRow("Focus order", subtitle: focusSummary, action: {
                    focusSummary = "Row action activated"
                }) {
                    Image(systemName: "keyboard")
                        .foregroundStyle(.secondary)
                } trailing: {
                    CNBadge("Keyboard", variant: .secondary)
                }

                CNField(label: "Priority") {
                    CNNativeSelect(
                        "Priority",
                        selection: $selectedPriority,
                        options: [
                            CNSelectOption("Required", value: "required"),
                            CNSelectOption("Recommended", value: "recommended"),
                            CNSelectOption("Optional", value: "optional"),
                        ]
                    )
                }

                CNDropdownMenu("Review actions", items: [
                    CNDropdownMenuItem(id: "copy", title: "Copy checklist", systemImage: "doc.on.doc"),
                    CNDropdownMenuItem(id: "flag", title: "Flag issue", systemImage: "flag"),
                    CNDropdownMenuItem(id: "pass", title: "Mark passed", systemImage: "checkmark.seal"),
                ]) { item in
                    focusSummary = item.title
                }
            }
            .padding(16)
        }
    }

    private var dynamicTypeSection: some View {
        CNSection("Dynamic Type", subtitle: "Text samples and compact controls for large content size checks.") {
            VStack(alignment: .leading, spacing: 12) {
                CNTypography("Heading sample", style: .heading)
                CNTypography("Body copy should wrap cleanly and keep enough space around controls at accessibility sizes.", style: .body)
                CNTypography("Muted helper text remains readable against card and background surfaces.", style: .muted)

                CNNote("Use the home screen Dynamic Type picker to switch between Default, XXL, and Accessibility sizes.", title: "Dynamic Type")
            }
            .padding(16)
        }
    }

    private var reducedMotionSection: some View {
        CNSection("Reduce Motion", subtitle: "Loading and motion surfaces that should remain meaningful without animation.") {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 14) {
                    CNSkeleton(shape: .circle, size: 48, label: "Loading avatar")

                    VStack(alignment: .leading, spacing: 8) {
                        CNSkeleton(width: 180, height: 18, label: "Loading title")
                        CNSkeleton(width: 260, height: 16, label: "Loading description")
                    }
                }

                HStack(spacing: 12) {
                    CNSpinner(size: 22, label: "Loading accessibility preview")
                    Text("Loading labels should still describe the pending state when motion is reduced.")
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }
            }
            .padding(16)
        }
    }

    private var matrixSection: some View {
        CNSection("QA Matrix", subtitle: "Pass/fail notes for the release accessibility review.") {
            CNTable(
                columns: [
                    CNTableColumn(id: "area", title: "Area", minWidth: 150),
                    CNTableColumn(id: "check", title: "Check", minWidth: 230),
                    CNTableColumn(id: "status", title: "Status", minWidth: 110),
                ],
                rows: [
                    CNTableRow(id: "voiceover", values: ["area": "VoiceOver", "check": "Readable roles and values", "status": "Manual"]),
                    CNTableRow(id: "keyboard", values: ["area": "Keyboard", "check": "Focusable controls and menus", "status": "Manual"]),
                    CNTableRow(id: "type", values: ["area": "Dynamic Type", "check": "No clipped labels", "status": "Manual"]),
                    CNTableRow(id: "motion", values: ["area": "Reduce Motion", "check": "No required animation", "status": "Manual"]),
                ]
            )
            .padding(16)
        }
    }

    private var checklistProgress: Double {
        let values = [voiceOverChecked, keyboardChecked, dynamicTypeChecked, reduceMotionChecked]
        let complete = values.filter { $0 }.count
        return Double(complete) / Double(values.count)
    }
}
