import NativeCN
import SwiftUI

struct CatalogFeedbackOverlaysPage: View {
    @State private var dialogPresented = false
    @State private var alertDialogPresented = false
    @State private var drawerPresented = false
    @State private var sheetPresented = false
    @State private var popoverPresented = false
    @State private var toast: CNToast?
    @State private var selectedAction = "None"
    @State private var selectedCommand = "None"

    var body: some View {
        CatalogPage(
            title: "Feedback & Overlays",
            subtitle: "Alerts, dialogs, sheets, toasts, popovers, and dropdown menus."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Alerts")
                    CNCardDescription("Inline status surfaces with semantic variants.")
                }

                CNCardContent {
                    VStack(spacing: 12) {
                        CNAlert("Update available", message: "A new version is ready.", variant: .default)
                        CNAlert("Profile saved", message: "Changes are available across devices.", variant: .success)
                        CNAlert("Storage almost full", message: "Clean up files soon.", variant: .warning)
                        CNAlert("Payment failed", message: "Update billing details.", variant: .destructive)
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Overlay Triggers")
                    CNCardDescription("Native presentation where possible, tokenized content where helpful.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            CNButton("Dialog", variant: .outline) {
                                dialogPresented = true
                            }

                            CNButton("Alert Dialog", variant: .outline) {
                                alertDialogPresented = true
                            }

                            CNButton("Sheet", variant: .outline) {
                                sheetPresented = true
                            }

                            CNButton("Drawer", variant: .outline) {
                                drawerPresented = true
                            }

                            CNButton("Toast", variant: .outline) {
                                toast = CNToast(title: "Saved", message: "Settings were updated.", variant: .success)
                            }
                        }

                        HStack {
                            CNButton("Popover", variant: .outline) {
                                popoverPresented = true
                            }
                            .cnPopover(isPresented: $popoverPresented) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Popover")
                                        .font(.headline)
                                    Text("Native popover presentation with NativeCN styling.")
                                }
                            }

                            CNButton("Hover card", variant: .outline) {}
                                .cnHoverCard {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack(spacing: 8) {
                                            CNAvatar(fallback: "NC", size: .sm)
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("NativeCN")
                                                    .font(.headline)
                                                Text("Design system workspace")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }

                                        Text("Hover on pointer devices or tap on touch layouts to preview related context.")
                                            .font(.subheadline)
                                    }
                                }

                            CNButton("Tooltip", variant: .outline) {}
                                .cnTooltip("Short contextual help for dense controls.")

                            CNDropdownMenu("Actions", items: [
                                CNDropdownMenuItem(id: "duplicate", title: "Duplicate", systemImage: "doc.on.doc"),
                                CNDropdownMenuItem(id: "archive", title: "Archive", systemImage: "archivebox"),
                                CNDropdownMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                            ]) { item in
                                selectedAction = item.title
                                toast = CNToast(title: "Selected", message: item.title, variant: item.isDestructive ? .warning : .default)
                            }

                            Text("Action: \(selectedAction)")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }

                        HStack(spacing: 10) {
                            CNButton("Info", variant: .ghost, size: .sm) {}
                                .cnTooltip(arrowEdge: .bottom) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Tooltip")
                                            .font(.headline)
                                        Text("Use it for a sentence of help, not a full preview card.")
                                    }
                                }

                            Text("Tooltips are for compact hints; hover cards are for richer previews.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Menubar")
                    CNCardDescription("Compact command menus for macOS-style tool surfaces.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 12) {
                        CNMenubar(menus: menubarMenus) { item in
                            selectedCommand = item.title
                            toast = CNToast(title: "Command", message: item.title)
                        }

                        Text("Command: \(selectedCommand)")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
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
        .cnAlertDialog(
            isPresented: $alertDialogPresented,
            title: "Delete project?",
            message: "This removes the project from the catalog workspace. This action cannot be undone.",
            actionTitle: "Delete",
            role: .destructive
        ) {
            toast = CNToast(title: "Deleted", message: "The project was removed.", variant: .warning)
        }
        .cnDrawer(
            isPresented: $drawerPresented,
            edge: .trailing,
            title: "Inspector",
            message: "A drawer keeps task-specific detail close to the current screen."
        ) {
            VStack(alignment: .leading, spacing: 14) {
                CNBadge("Stable", variant: .secondary)
                Text("Component checklist")
                    .font(.headline)
                CNDescriptionList([
                    CNDescriptionItem(id: "state", label: "State", value: "Presented"),
                    CNDescriptionItem(id: "edge", label: "Edge", value: "Trailing"),
                    CNDescriptionItem(id: "dismiss", label: "Dismiss", value: "Backdrop tap"),
                ])
                CNButton("Close", variant: .outline) {
                    drawerPresented = false
                }
            }
        }
        .cnSheet(isPresented: $sheetPresented, title: "Sheet", message: "Native sheet presentation with tokenized content.") {
            VStack(alignment: .leading, spacing: 16) {
                CNAlert("Sheet content", message: "Use sheets for focused flows.", variant: .default)
                CNButton("Done") {
                    sheetPresented = false
                }
            }
        }
    }

    private var menubarMenus: [CNMenubarMenu] {
        [
            CNMenubarMenu(id: "file", title: "File", systemImage: "doc", items: [
                CNMenubarItem(id: "new", title: "New Project", systemImage: "plus", shortcut: "Command N"),
                CNMenubarItem(id: "open", title: "Open", systemImage: "folder", shortcut: "Command O"),
                CNMenubarItem(id: "export", title: "Export", systemImage: "square.and.arrow.up", isDisabled: true),
            ]),
            CNMenubarMenu(id: "edit", title: "Edit", systemImage: "slider.horizontal.3", items: [
                CNMenubarItem(id: "duplicate", title: "Duplicate", systemImage: "doc.on.doc"),
                CNMenubarItem(id: "archive", title: "Archive", systemImage: "archivebox"),
                CNMenubarItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
            ]),
        ]
    }
}
