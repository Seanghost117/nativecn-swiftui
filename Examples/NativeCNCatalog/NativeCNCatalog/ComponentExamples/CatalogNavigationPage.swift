import NativeCN
import SwiftUI

struct CatalogNavigationPage: View {
    @State private var tab = "overview"
    @State private var density = "comfortable"
    @State private var selectedCrumb = "None"
    @State private var sidebar = "overview"
    @State private var menu = "overview"

    var body: some View {
        CatalogPage(
            title: "Navigation",
            subtitle: "Hierarchy and local navigation controls for app screens."
        ) {
            CNSection("Breadcrumb", subtitle: "Useful for iPad and macOS hierarchy.") {
                CNListRow("Current path", subtitle: selectedCrumb) {
                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                        .foregroundStyle(.secondary)
                } trailing: {
                    CNBreadcrumb(items: breadcrumbItems) { item in
                        selectedCrumb = item.title
                    }
                }
            }

            CNSection("Tabs", subtitle: "Token-styled tab triggers with app-owned content.") {
                VStack(alignment: .leading, spacing: 16) {
                    CNTabs(selection: $tab, items: [
                        CNTabItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
                        CNTabItem("Tasks", value: "tasks", systemImage: "checklist"),
                        CNTabItem("Files", value: "files", systemImage: "folder"),
                    ])

                    CNCard {
                        CNCardHeader {
                            CNCardTitle(tabTitle)
                            CNCardDescription("The selected tab value is \(tab).")
                        }
                    }
                }
                .padding(16)
            }

            CNSection("Navigation Menu", subtitle: "Top-level app navigation with native menu-backed child items.") {
                VStack(alignment: .leading, spacing: 16) {
                    CNNavigationMenu(selection: $menu, groups: menuGroups)

                    CNCard {
                        CNCardHeader {
                            CNCardTitle(menuTitle)
                            CNCardDescription("Selected menu value: \(menu)")
                        }
                    }
                }
                .padding(16)
            }

            CNSection("Segmented Control", subtitle: "Compact mode and filter switching.") {
                VStack(alignment: .leading, spacing: 16) {
                    CNSegmentedControl(selection: $density, options: [
                        CNSegmentedControlOption("Compact", value: "compact"),
                        CNSegmentedControlOption("Comfortable", value: "comfortable"),
                        CNSegmentedControlOption("Spacious", value: "spacious"),
                    ])

                    Text("Density: \(density.capitalized)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
            }

            CNSection("Sidebar", subtitle: "Grouped app-shell navigation for iPad and macOS layouts.") {
                HStack(alignment: .top, spacing: 16) {
                    CNSidebar("Workspace", selection: $sidebar, sections: sidebarSections)
                        .frame(width: 260)

                    CNCard {
                        CNCardHeader {
                            CNCardTitle(sidebarTitle)
                            CNCardDescription("Selected sidebar value: \(sidebar)")
                        }

                        CNCardContent {
                            CNNote("Use sidebars for durable app destinations, project sections, and workspace-level navigation.", title: "Navigation guidance")
                        }
                    }
                }
                .padding(16)
            }
        }
    }

    private var breadcrumbItems: [CNBreadcrumbItem] {
        [
            CNBreadcrumbItem(id: "home", title: "Home", systemImage: "house"),
            CNBreadcrumbItem(id: "projects", title: "Projects"),
            CNBreadcrumbItem(id: "nativecn", title: "NativeCN", isCurrent: true),
        ]
    }

    private var tabTitle: String {
        switch tab {
        case "tasks":
            return "Tasks"
        case "files":
            return "Files"
        default:
            return "Overview"
        }
    }

    private var sidebarSections: [CNSidebarSection<String>] {
        [
            CNSidebarSection(id: "workspace", title: "Workspace", items: [
                CNSidebarItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
                CNSidebarItem("Inbox", value: "inbox", systemImage: "tray", badge: "4"),
                CNSidebarItem("Files", value: "files", systemImage: "folder"),
            ]),
            CNSidebarSection(id: "admin", title: "Admin", items: [
                CNSidebarItem("Members", value: "members", systemImage: "person.2"),
                CNSidebarItem("Billing", value: "billing", systemImage: "creditcard"),
                CNSidebarItem("Audit log", value: "audit", systemImage: "lock.doc", isDisabled: true),
            ]),
        ]
    }

    private var sidebarTitle: String {
        sidebarSections
            .flatMap(\.items)
            .first { $0.value == sidebar }?
            .title ?? "Overview"
    }

    private var menuGroups: [CNNavigationMenuGroup<String>] {
        [
            CNNavigationMenuGroup(id: "overview", title: "Overview", systemImage: "square.grid.2x2", value: "overview"),
            CNNavigationMenuGroup(id: "projects", title: "Projects", systemImage: "folder", items: [
                CNNavigationMenuItem("Active", value: "active-projects", subtitle: "Open work", systemImage: "folder"),
                CNNavigationMenuItem("Archived", value: "archived-projects", subtitle: "Closed work", systemImage: "archivebox"),
            ]),
            CNNavigationMenuGroup(id: "reports", title: "Reports", systemImage: "chart.bar", items: [
                CNNavigationMenuItem("Usage", value: "usage", systemImage: "chart.line.uptrend.xyaxis", badge: "New"),
                CNNavigationMenuItem("Audit Log", value: "audit-log", systemImage: "lock.doc", isDisabled: true),
            ]),
        ]
    }

    private var menuTitle: String {
        if let direct = menuGroups.first(where: { $0.value == menu }) {
            return direct.title
        }

        return menuGroups
            .flatMap(\.items)
            .first { $0.value == menu }?
            .title ?? "Overview"
    }
}
